import 'dart:async';
import 'dart:convert';
import 'package:bounty_hunter/models/countrys_entity.dart';
import 'package:bounty_hunter/models/wa_entity.dart';
import 'package:bounty_hunter/models/wacode_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/setting/iview/wa_activation_page_iview.dart';
import 'package:bounty_hunter/setting/presenter/wa_activation_presenter.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sp_util/sp_util.dart';

/// WhatsApp 激活页面
class WaActivationPage extends StatefulWidget {
  const WaActivationPage({super.key});

  @override
  State<WaActivationPage> createState() => _WaActivationPageState();
}

class _WaActivationPageState extends State<WaActivationPage>
    with BasePageMixin<WaActivationPage, WaActivationPresenter>
    implements WaActivationPageMvpView {
  static const String _waCooldownKey = 'wa_activation_next_request_time';
  static const String _waDataKey = 'wa_activation_last_data';
  static const String _selectedCountryKey = 'wa_activation_selected_country';
  static const String _weeklyNoticeAckKey = 'wa_activation_weekly_notice_ack';
  

  
  late WaActivationPresenter _waActivationPresenter;
  WaData? _waData;
  WacodeData? _wacodeData;
  Timer? _codePollingTimer;
  bool _isPolling = false;
  DateTime? _nextWaRequestTime;
  Timer? _waCooldownTimer;
  String _selectedCountry = '';

  // 国家列表（后续由后台接口填充）
  List<String> _countries = <String>[];

  // 国家名 -> 国家区号（后续由后台接口填充）
  Map<String, String> _countryCodes = <String, String>{};

  // 国家名 -> 成功率（后续由后台接口填充）
  Map<String, int> _countryRates = <String, int>{};

  @override
  WaActivationPresenter createPresenter() {
    _waActivationPresenter = WaActivationPresenter();
    return _waActivationPresenter;
  }

  @override
  void initState() {
    super.initState();
    _loadWaCooldown();
    _loadStoredWaData();
  }

  @override
  Future<void> showWeeklyNotice() async {
    if (!mounted) return;
    final DateTime now = DateTime.now();
    // DateTime.weekday: Monday=1 ... Sunday=7
    // if (now.weekday != DateTime.monday) return;

    final DateTime monday = DateUtils.dateOnly(
      now.subtract(Duration(days: now.weekday - DateTime.monday)),
    );
    final String weekId =
        '1${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
    final String? ackWeekId = SpUtil.getString(_weeklyNoticeAckKey);
    if (ackWeekId == weekId) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('WhatsApp Account Anti-Ban & Recovery Instructions'),
          content: const SingleChildScrollView(
            child: Text(
              'I. Daily WhatsApp Anti-Ban Rules\n'
              '1. Do not frequently switch WhatsApp accounts, add contacts in bulk, or send identical copied messages in WhatsApp.\n'
              '2. Do not send external links, payment information, sensitive words, or promotional advertisements via WhatsApp.\n'
              '3. Avoid frequent logouts and logins on WhatsApp; keep a stable network environment.\n'
              '4. After logging in with a new WhatsApp number, start with light messaging and avoid sending mass messages immediately.\n\n'
              'II. Actions After WhatsApp Is Banned\n'
              '1. Once WhatsApp shows a ban, stop all activity on that device immediately.\n'
              '2. If another mobile phone is available, use the new device to log in to the company APP and obtain a new WhatsApp number.\n'
              '3. The new device used for logging into the new WhatsApp account must use a separate network / IP address and must not share the same network or IP as the banned device.',
              style: TextStyle(height: 1.45),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SpUtil.putString(_weeklyNoticeAckKey, weekId);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Notice acknowledged'),
            ),
          ],
        );
      },
    );
  }

  @override
  void setCountryData(List<CountrysData>? data) {
    final List<CountrysData> list = data ?? <CountrysData>[];
    if (list.isEmpty) return;

    final List<String> names = list
        .map((CountrysData e) => e.name ?? '')
        .where((String name) => name.isNotEmpty)
        .toList();

    final Map<String, String> codes = <String, String>{
      for (final CountrysData e in list)
        if ((e.name ?? '').isNotEmpty) (e.name ?? ''): (e.code ?? '')
    };

    final Map<String, int> rates = <String, int>{
      for (final CountrysData e in list)
        if ((e.name ?? '').isNotEmpty) (e.name ?? ''): (e.rate ?? 0)
    };

    setState(() {
      _countries = names;
      _countryCodes = codes;
      _countryRates = rates;
      _selectedCountry = _countries.isNotEmpty ? _countries.first : '';
    });

    // 如果本地已保存了选择，则优先使用本地记录
    _loadSelectedCountry();
  }
  /// 加载保存的国家选择
  void _loadSelectedCountry() {
    final String? savedCountry = SpUtil.getString(_selectedCountryKey);
    if (savedCountry != null && _countries.contains(savedCountry)) {
      setState(() {
        _selectedCountry = savedCountry;
      });
    }
  }
  
  /// 保存国家选择
  void _saveSelectedCountry(String country) {
    SpUtil.putString(_selectedCountryKey, country);
  }

  @override
  void dispose() {
    _codePollingTimer?.cancel();
    _waCooldownTimer?.cancel();
    super.dispose();
  }

  @override
  void setWaData(WaData? data) {
    final bool hasNumber =
        data != null && data.wa != null && data.wa!.isNotEmpty;

    setState(() {
      _waData = data;
      if (hasNumber) {
        _nextWaRequestTime = DateTime.now().add(const Duration(seconds: 1));
        SpUtil.putInt(
            _waCooldownKey, _nextWaRequestTime!.millisecondsSinceEpoch);
      }
    });

    if (data != null) {
      final Map<String, dynamic> storeMap = {
        'wa': data.wa,
        'activation_id': data.activationId,
        'tip': data.tip,
        'tip2': data.tip2,
      };
      SpUtil.putString(_waDataKey, jsonEncode(storeMap));
    } else {
      SpUtil.remove(_waDataKey);
    }

    if (hasNumber) {
      _startWaCooldownTimer();
      showToast(
          'Please copy this number to WhatsApp or WhatsApp Business and login with it');
      // 自动开始轮询验证码
      if (data.activationId != null && data.activationId!.isNotEmpty) {
        // 如果已经有轮询在进行，先停止
        if (_isPolling) {
          _stopPolling();
        }
        // 延迟一小段时间后开始轮询，确保状态已更新
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && _waData?.activationId != null) {
            _startPollingCode();
          }
        });
      }
    }
  }

  @override
  void setWacodeData(WacodeData? data) {
    if (data != null && data.code != null && data.code!.isNotEmpty) {
      setState(() {
        _wacodeData = data;
        _isPolling = false;
      });
      _codePollingTimer?.cancel();
      showToast('Code received! Please copy it to WhatsApp');
    }
  }

  /// 获取 WhatsApp 号码
  void _getWaNumber() {
    if (_isWaCooldownActive) {
      showToast('Please wait before requesting a new number.');
      return;
    }
    if (_selectedCountry.isEmpty) {
      showToast('Please select country first');
      return;
    }
    _waActivationPresenter.getWaNumber(country: _selectedCountry);
  }

  /// 开始轮询获取验证码
  void _startPollingCode() {
    if (_waData?.activationId == null || _waData!.activationId!.isEmpty) {
      showToast('Please get WhatsApp number first');
      return;
    }

    setState(() {
      _isPolling = true;
      _wacodeData = null;
    });

    // 立即请求一次
    _waActivationPresenter.getWaCode(_waData!.activationId!);

    // 每5秒请求一次
    _codePollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _waActivationPresenter.getWaCode(_waData!.activationId!);
    });
  }

  /// 停止轮询
  void _stopPolling() {
    _codePollingTimer?.cancel();
    setState(() {
      _isPolling = false;
    });
  }

  /// 复制号码
  void _copyWaNumber() {
    if (_waData?.wa != null && _waData!.wa!.isNotEmpty) {
      FlutterClipboard.copy(_waData!.wa!);
      showToast('WhatsApp number copied');
    }
  }

  /// 复制验证码
  void _copyCode() {
    if (_wacodeData?.code != null && _wacodeData!.code!.isNotEmpty) {
      FlutterClipboard.copy(_wacodeData!.code!);
      showToast('Code copied');
    }
  }

  bool get _isWaCooldownActive {
    if (_nextWaRequestTime == null) return false;
    return DateTime.now().isBefore(_nextWaRequestTime!);
  }

  String _waCooldownText() {
    if (!_isWaCooldownActive || _nextWaRequestTime == null) {
      return '';
    }
    final Duration remaining = _nextWaRequestTime!.difference(DateTime.now());
    final int minutes = remaining.inMinutes;
    final int seconds = remaining.inSeconds % 60;
    return 'Please wait ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} to request a new number.';
  }

  void _startWaCooldownTimer() {
    _waCooldownTimer?.cancel();
    if (!_isWaCooldownActive) {
      _nextWaRequestTime = null;
      SpUtil.remove(_waCooldownKey);
      return;
    }
    _waCooldownTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (!_isWaCooldownActive) {
        timer.cancel();
        setState(() {
          _nextWaRequestTime = null;
        });
        SpUtil.remove(_waCooldownKey);
      } else {
        setState(() {});
      }
    });
  }

  Future<void> _loadWaCooldown() async {
    final int? storedTimestamp = SpUtil.getInt(_waCooldownKey);
    if (storedTimestamp == null) return;

    final DateTime storedTime =
        DateTime.fromMillisecondsSinceEpoch(storedTimestamp);
    if (DateTime.now().isBefore(storedTime)) {
      setState(() {
        _nextWaRequestTime = storedTime;
      });
      _startWaCooldownTimer();
    } else {
      SpUtil.remove(_waCooldownKey);
    }
  }

  void _loadStoredWaData() {
    final String? stored = SpUtil.getString(_waDataKey);
    if (stored == null || stored.isEmpty) return;
    try {
      final Map<String, dynamic> map =
          jsonDecode(stored) as Map<String, dynamic>;
      final WaData storedData = WaData()
        ..wa = map['wa'] as String?
        ..activationId = map['activation_id'] as String?
        ..tip = map['tip'] as String?
        ..tip2 = map['tip2'] as String?;
      setState(() {
        _waData = storedData;
      });
    } catch (_) {
      SpUtil.remove(_waDataKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'WhatsApp Activation',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 获取 WhatsApp 号码部分
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Step 1: Get WhatsApp Number',
                      style: TextStyles.textBold16,
                    ),
                    Gaps.vGap16,
                    // 国家选择
                    Text(
                      'Country',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colours.bg_gray,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colours.line),
                      ),
                      child: DropdownButton<String>(
                        value: _countries.contains(_selectedCountry)
                            ? _selectedCountry
                            : (_countries.isNotEmpty ? _countries.first : null),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        icon: const Icon(Icons.arrow_drop_down),
                        style: TextStyle(color: Theme.of(context).textTheme.titleSmall?.color),
                        dropdownColor: Theme.of(context).colorScheme.surface,
                        items: _countries.asMap().entries
                            .map<DropdownMenuItem<String>>((entry) {
                          final int index = entry.key;
                          final String country = entry.value;
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(
                              _countryCodes[country] != null
                                  ? '$country (${_countryCodes[country]})  Success: ${_countryRates[country] ?? 0}%'
                                  : '$country  Success: ${_countryRates[country] ?? 0}%',
                              style: TextStyle(
                                color: index < 2
                                    ? Colors.green
                                    : Theme.of(context).textTheme.titleSmall?.color,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newCountry) {
                          if (newCountry != null) {
                            setState(() {
                              _selectedCountry = newCountry;
                            });
                            _saveSelectedCountry(newCountry);
                          }
                        },
                      ),
                    ),
                    Gaps.vGap8,
                    Text(
                      'Selected country code: ${_countryCodes[_selectedCountry] ?? ''}',
                      style: TextStyles.textGray12,
                    ),
                    Gaps.vGap16,
                    MyButton(
                      text: _isWaCooldownActive
                          ? 'Please wait before requesting again'
                          : 'Get WhatsApp Number',
                      onPressed: _isWaCooldownActive ? null : _getWaNumber,
                    ),
                    if (_isWaCooldownActive) ...[
                      Gaps.vGap8,
                      Text(
                        _waCooldownText(),
                        style: TextStyles.textGray12,
                      ),
                    ],
                    if (_waData != null &&
                        _waData!.wa != null &&
                        _waData!.wa!.isNotEmpty) ...[
                      Gaps.vGap16,
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colours.bg_gray,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _waData!.wa!,
                                style: TextStyles.textBold16,
                              ),
                            ),
                            SizedBox(width: 160, child: MyButton(onPressed: _copyWaNumber, text: 'Copy number',icon: Icons.content_copy,)),
                            // IconButton(
                            //   icon: const Icon(Icons.content_copy),
                            //   onPressed: _copyWaNumber,
                            //   tooltip: 'Copy number',
                            // ),
                          ],
                        ),
                      ),
                      if (_waData!.tip != null && _waData!.tip!.isNotEmpty) ...[
                        Gaps.vGap12,
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.info_outline, color: Colors.blue[700]),
                              Gaps.hGap8,
                              Expanded(
                                child: Text(
                                  _waData!.tip!,
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (_waData!.tip2 != null &&
                          _waData!.tip2!.isNotEmpty) ...[
                        Gaps.vGap8,
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.info_outline, color: Colors.blue[700]),
                              Gaps.hGap8,
                              Expanded(
                                child: Text(
                                  _waData!.tip2!,
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
            Gaps.vGap16,
            // 获取验证码部分
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //去whatsapp登录页面，点击获取验证码
                      'Step 2: Go to WhatsApp login page and click get verification code',
                      style: TextStyles.textBold16,
                    ),
                    Gaps.vGap16,
                    MyButton(
                      fontSize: 14,
                      text: _isPolling
                          ? 'Polling...'
                          : 'I have sent WhatsApp verification code',
                      onPressed: _isPolling ? null : _startPollingCode,
                    ),
                    if (_isPolling) ...[
                      Gaps.vGap12,
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          Gaps.hGap8,
                          Text(
                            'Polling for code every 5 seconds...',
                            style: TextStyles.textGray14,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      MyButton(
                        text: 'Stop Polling',
                        onPressed: _stopPolling,
                        backgroundColor: Colors.red,
                      ),
                    ],
                    if (_wacodeData != null &&
                        _wacodeData!.code != null &&
                        _wacodeData!.code!.isNotEmpty) ...[
                      Gaps.vGap16,
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.check_circle,
                                    color: Colors.green[700]),
                                Gaps.hGap8,
                                Text(
                                  'Verification Code Received',
                                  style: TextStyles.textBold14.copyWith(
                                    color: Colors.green[900],
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap12,
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.green[300]!),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _wacodeData!.code!,
                                      style: TextStyles.textBold18.copyWith(
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.content_copy),
                                    onPressed: _copyCode,
                                    tooltip: 'Copy code',
                                  ),
                                ],
                              ),
                            ),
                            Gaps.vGap8,
                            Text(
                              'Please copy this code to WhatsApp to complete login',
                              style: TextStyles.textGray12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Gaps.vGap16,
            // 警告提示
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange[700]),
                      Gaps.hGap8,
                      Text(
                        'Important Warning',
                        style: TextStyles.textBold14.copyWith(
                          color: Colors.orange[900],
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap12,
                  Text(
                    'Please use this feature with caution. Frequently operating to get verification codes on a single phone device may cause WhatsApp to mark your device as a risky device. Once marked, your WhatsApp account on this phone will have a higher probability and frequency of being banned.',
                    style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  Gaps.vGap8,
                  Text(
                    'If possible, please exchange phones with your friends and family periodically to use this Flutter app. On new phone devices, WhatsApp is less likely to mark them as risky devices.',
                    style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap16,
          ],
        ),
      ),
    );
  }
}
