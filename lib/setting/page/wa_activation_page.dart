import 'dart:async';
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

/// WhatsApp 激活页面
class WaActivationPage extends StatefulWidget {
  const WaActivationPage({super.key});

  @override
  State<WaActivationPage> createState() => _WaActivationPageState();
}

class _WaActivationPageState extends State<WaActivationPage>
    with BasePageMixin<WaActivationPage, WaActivationPresenter>
    implements WaActivationPageMvpView {
  late WaActivationPresenter _waActivationPresenter;
  WaData? _waData;
  WacodeData? _wacodeData;
  Timer? _codePollingTimer;
  bool _isPolling = false;

  @override
  WaActivationPresenter createPresenter() {
    _waActivationPresenter = WaActivationPresenter();
    return _waActivationPresenter;
  }

  @override
  void dispose() {
    _codePollingTimer?.cancel();
    super.dispose();
  }

  @override
  void setWaData(WaData? data) {
    setState(() {
      _waData = data;
    });
    if (data != null && data.wa != null && data.wa!.isNotEmpty) {
      showToast(
          'Please copy this number to WhatsApp or WhatsApp Business and login with it');
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
    _waActivationPresenter.getWaNumber();
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
                    MyButton(
                      text: 'Get WhatsApp Number',
                      onPressed: _getWaNumber,
                    ),
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
                            IconButton(
                              icon: const Icon(Icons.content_copy),
                              onPressed: _copyWaNumber,
                              tooltip: 'Copy number',
                            ),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Step 2: Get Verification Code',
                      style: TextStyles.textBold16,
                    ),
                    Gaps.vGap16,
                    MyButton(
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
          ],
        ),
      ),
    );
  }
}
