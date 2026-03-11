import 'dart:async';

import 'package:bounty_hunter/models/collection_order_entity.dart';
import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/order/iview/sms_history_page_iview.dart';
import 'package:bounty_hunter/order/presenter/sms_history_page_presenter.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bounty_hunter/util/theme_utils.dart';

class SmsHistoryPage extends StatefulWidget {
  const SmsHistoryPage({
    super.key,
    required this.repayInfo,
    required this.borrowId,
    required this.collectionOrderId,
    required this.period,
  });
  final int collectionOrderId;
  final CollectionLogOtherRepayInfo? repayInfo;
  final int borrowId;
  final CollectionLogOtherPeriod period;
  @override
  State<SmsHistoryPage> createState() => _SmsHistoryPageState();
}

class _SmsHistoryPageState extends State<SmsHistoryPage>
    with
        BasePageMixin<SmsHistoryPage, SmsHistoryPresenter>,
        WidgetsBindingObserver
    implements SmsHistoryPageMvpView {
  List<HKContactSmsData> _list = <HKContactSmsData>[];
  late SmsHistoryPresenter _smsHistoryPresenter;
  int _selectedIndex = -1;
  DateTime? _appPausedTime;
  DateTime? _appResumedTime;
  bool _isWhatsAppLaunched = false;
  bool _isCallLaunched = false;
  bool _isSmsLaunched = false;
  int? _currentTemplateId; // 存储当前选中的模板ID
  Timer? _cleanupTimer; // 清理定时器
  String? _lastActionSource; // 记录最后一次操作来源：'call', 'sms', 'whatsapp'
  int method = 0;
  HKContactSmsData? _record;

  @override
  SmsHistoryPresenter createPresenter() {
    _smsHistoryPresenter = SmsHistoryPresenter();
    return _smsHistoryPresenter;
  }

  @override
  void onRefresh() {
    _smsHistoryPresenter.index(
        widget.borrowId, 1, true); // Implement your logic her
  }

  @override
  void setList(List<HKContactSmsData> list) {
    setState(() {
      _list = list;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cleanupTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        // 应用进入后台（比如打开WhatsApp）
        _appPausedTime = DateTime.now();
        print('App paused at: $_appPausedTime');
        break;
      case AppLifecycleState.resumed:
        // 应用回到前台
        _appResumedTime = DateTime.now();
        print('App resumed at: $_appResumedTime');

        // 如果之前有暂停时间，计算时间差
        if (_appPausedTime != null) {
          final Duration timeSpentOutside =
              _appResumedTime!.difference(_appPausedTime!);
          print(
              'Time spent outside app: ${timeSpentOutside.inSeconds} seconds');

          // 如果是从WhatsApp返回且停留时间超过5秒，记录点击事件
          if (_isWhatsAppLaunched && timeSpentOutside.inSeconds > 1) {
            _recordWhatsAppClick();
          }
          if (_isCallLaunched && timeSpentOutside.inSeconds > 2) {
            _recordCallClick();
          }
          if (_isSmsLaunched && timeSpentOutside.inSeconds > 1) {
            _recordSmsClick();
          }
          _isWhatsAppLaunched = false;
          _isCallLaunched = false;
          _isSmsLaunched = false;
          _currentTemplateId = null;
          _cleanupTimer?.cancel(); // 清理定时器
        }
        break;
      default:
        break;
    }
  }

  Future<void> _recordSmsClick() async {
    String type = '3';

    final templateId = _currentTemplateId ?? 0;
    await Cache().appendToStringList('action_sms_history',
        '$type:${widget.collectionOrderId}:${_record!.id}:$templateId');
    // 同时更新存储中的联系人列表
    _currentTemplateId = null;
  }

  Future<void> _recordCallClick() async {
    String type = '2';
    await Cache().appendToStringList('action_sms_history',
        '$type:${widget.collectionOrderId}:${_record!.id}:0');
  }

  Future<void> _recordWhatsAppClick() async {
    // 使用保存的模板ID记录点击事件
    String type = '1';

    final templateId = _currentTemplateId ?? 0;
    await Cache().appendToStringList('action_sms_history',
        '$type:${widget.collectionOrderId}:${_record!.id}:$templateId');

    // 重置模板ID
    _currentTemplateId = null;
  }

  Future<void> _callContact(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'cant launch $url';
    }
  }

  int calculateCalendarDaysDifference(DateTime start, DateTime end) {
    // 将两个日期都设置为午夜时间，只比较日期部分
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);
    return end.difference(start).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final int overdueDays = calculateCalendarDaysDifference(
        DateTime.parse(widget.repayInfo!.expectRepayTime!), DateTime.now());
    final List<Map<String, dynamic>> dataList =
        SpUtil.getObjectList('hJSmsTemplates')!.cast<Map<String, dynamic>>();
    // 先过滤e_days为1的元素，再进行后续处理
    final List<CollectionLogOtherHJSmsTemplate> templates2 =
        List<CollectionLogOtherHJSmsTemplate>.from(dataList.where((value) {
      return value['c_type'] == 28;
    }).map((value) {
      final template = $CollectionLogOtherHJSmsTemplateFromJson(value);
      // 替换所有占位符
      String processedTemplate = template.dTemplate!
          .replaceAll(
              '@expect_repay_amount@',
              Utils.formatPrice2((widget.period!.fExpectRepayTotalAmount ?? 0) -
                  (widget.period!.qPaidServiceFee ?? 0) -
                  (widget.period!.pPaidInterest ?? 0) -
                  (widget.period!.sPaidOverdueAmount ?? 0) -
                  (widget.period!.oPaidBorrowAmount ?? 0) -
                  (widget.period!.uDeductionTotalAmount ?? 0)))
          .replaceAll(
              '@expect_repay_time@',
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(widget.repayInfo!.expectRepayTime!)))
          .replaceAll(
              '@overdue_days@', widget.repayInfo!.overdueDays.toString())
          .replaceAll('@mobile@', widget.repayInfo!.mobile!)
          .replaceAll('@phone@', widget.repayInfo!.phone!)
          .replaceAll('@bvn@', widget.repayInfo!.bvn!)
          .replaceAll('@name@', widget.repayInfo!.name!)
          .replaceAll('@borrow_amount@',
              Utils.formatPrice2(widget.period!.oPaidBorrowAmount!))
          .replaceAll('@loan_amount@',
              Utils.formatPrice2(widget.period!.oPaidBorrowAmount!))
          .replaceAll('@borrow_days@', widget.repayInfo!.borrowDays.toString())
          .replaceAll('@app_name@', widget.repayInfo!.appName!)
          .replaceAll('@url@', widget.repayInfo!.url!)
          .replaceAll('@product_name@', widget.repayInfo!.productName!)
          .replaceAll('@loan_time@', widget.repayInfo!.loanTime!)
          .replaceAll('@receive_bank@', widget.repayInfo!.receiveBank!)
          .replaceAll('@receive_bank_no@', widget.repayInfo!.receiveBankNo!)
          .replaceAll('@account_name@', widget.repayInfo!.accountName!)
          .replaceAll('@account_no@', widget.repayInfo!.accountNo!)
          .replaceAll('@account_bank@', widget.repayInfo!.accountBank!)
          .replaceAll(
              '@before_credit_amount@', widget.repayInfo!.beforeCreditAmount!)
          .replaceAll(
              '@after_credit_amount@', widget.repayInfo!.afterCreditAmount!)
          .replaceAll(
              '@change_credit_amount@', widget.repayInfo!.changeCreditAmount!)
          .replaceAll('@before_credit_fraction@',
              widget.repayInfo!.beforeCreditFraction!)
          .replaceAll(
              '@after_credit_fraction@', widget.repayInfo!.afterCreditFraction!)
          .replaceAll('@change_credit_fraction@',
              widget.repayInfo!.changeCreditFraction!)
          .replaceAll('@var1@', widget.repayInfo!.var1!)
          .replaceAll('@var2@', widget.repayInfo!.var2!)
          .replaceAll('@var3@', widget.repayInfo!.var3!)
          .replaceAll('@var4@', widget.repayInfo!.var4!)
          .replaceAll('@var5@', widget.repayInfo!.var5!)
          .replaceAll('@var6@', widget.repayInfo!.var6!)
          .replaceAll('@var7@', widget.repayInfo!.var7!)
          .replaceAll('@var8@', widget.repayInfo!.var8!)
          .replaceAll('@var9@', widget.repayInfo!.var9!)
          .replaceAll('@var10@', widget.repayInfo!.var10!);
      return template.copyWith(dTemplate: processedTemplate);
    })).toList();

    Future<void> launchAction2(int type, HKContactSmsData record) async {
      // 显示模板选择对话框
      if (type != 2) {
        final CollectionLogOtherHJSmsTemplate? selectedTemplate =
            await showModalBottomSheet<CollectionLogOtherHJSmsTemplate>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: templates2.map((template) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () => Navigator.pop(context, template),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            template.sName ?? 'Empty message.',
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
        if (selectedTemplate != null) {
          if (type == 1) {
            await Cache().appendToStringList('action_sms_history',
                '$type:${widget.collectionOrderId}:${record.id}:${selectedTemplate.id}');
            Utils.launchWhatsAppURL('234${record.address!}',
                message: selectedTemplate.dTemplate);
          } else if (type == 3) {
            await Cache().appendToStringList('action_sms_history',
                '$type:${widget.collectionOrderId}:${record.id}:${selectedTemplate.id}');
            launch('sms:${record.address}?body=${selectedTemplate.dTemplate}');
          }
        }
      } else if (type == 2) {
        await Cache().appendToStringList('action_sms_history',
            '$type:${widget.collectionOrderId}:${record.id}:0');
        final url = 'tel:${record.address}';
        if (await canLaunch(url)) {
          await launch(url);
        }
      }
    }

    Future<void> launchAction(int type, HKContactSmsData record) async {
      //type 1:whatsapp 2:call 3:sms
      setState(() {
        _record = record;
      });
      // 显示模板选择对话框
      if (type != 2) {
        // 在 showModalBottomSheet 外部创建状态变量，确保在重建时保持
        int? expandedIndex;
        final CollectionLogOtherHJSmsTemplate? selectedTemplate =
            await showModalBottomSheet<CollectionLogOtherHJSmsTemplate>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: templates2.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final template = entry.value;
                        final bool isExpanded = expandedIndex == index;
                        return _TemplateItem(
                          template: template,
                          isExpanded: isExpanded,
                          onSelect: () => Navigator.pop(context, template),
                          onToggleExpand: () {
                            setState(() {
                              // 如果点击的是已展开的项，则收起；否则展开该项并收起其他项
                              expandedIndex =
                                  expandedIndex == index ? null : index;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            );
          },
        );
        if (selectedTemplate != null) {
          if (type == 1) {
            // 启动WhatsApp
            final bool result = await Utils.launchWhatsAppURL(
                '234${record.address!}',
                message: selectedTemplate.dTemplate);
            if (result) {
              // 设置WhatsApp启动标志，等待用户返回应用
              _isWhatsAppLaunched = true;
              _currentTemplateId = selectedTemplate.id; // 保存模板ID
              print('WhatsApp launched, waiting for user to return...');

              // 启动清理定时器，60秒后自动清理状态
              _cleanupTimer?.cancel();
              _cleanupTimer = Timer(const Duration(seconds: 60), () {
                if (mounted) {
                  setState(() {
                    _isWhatsAppLaunched = false;
                    _currentTemplateId = null;
                  });
                }
              });

              setState(() {});
            }
          } else if (type == 3) {
            // 启动Sms
            final bool result = await launch(
                'sms:${record.address}?body=${selectedTemplate.dTemplate}');
            if (result) {
              // 设置Sms启动标志，等待用户返回应用
              _isSmsLaunched = true;
              _currentTemplateId = selectedTemplate.id; // 保存模板ID
              print('Sms launched, waiting for user to return...');

              // 启动清理定时器，60秒后自动清理状态
              _cleanupTimer?.cancel();
              _cleanupTimer = Timer(const Duration(seconds: 60), () {
                if (mounted) {
                  setState(() {
                    _isSmsLaunched = false;
                    _currentTemplateId = null;
                  });
                }
              });

              setState(() {});
            }
          }
        }
      } else if (type == 2) {
        // 启动Call
        final url = 'tel:${record.address}';
        if (await canLaunch(url)) {
          final bool result = await launch(url);
          if (result) {
            // 设置Call启动标志，等待用户返回应用
            _isCallLaunched = true;
            print('Call launched, waiting for user to return...');

            // 启动清理定时器，60秒后自动清理状态
            _cleanupTimer?.cancel();
            _cleanupTimer = Timer(const Duration(seconds: 60), () {
              if (mounted) {
                setState(() {
                  _isCallLaunched = false;
                  _currentTemplateId = null;
                });
              }
            });

            setState(() {});
          }
        }
      }
    }

    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
      color: ThemeUtils.getBackgroundColor(context),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeUtils.getBackgroundColor(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final record = _list[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              shadowColor: ThemeUtils.getShadowColor(context),
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 116, 133, 146)
                  : ThemeUtils.getBackgroundColor(context),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                            record.aAContactId! > 0
                                ? Icons.perm_contact_calendar
                                : Icons.device_unknown,
                            size: 16,
                            color: record.aAContactId! > 0
                                ? Colors.blueAccent
                                : Colors.grey.shade400),
                        Text(
                          record.aBContactName != null &&
                                  record.aBContactName!.isNotEmpty
                              ? record.aBContactName!
                              : record.address!,
                          style: TextStyle(fontSize: 14, color: ThemeUtils.getTextColor(context)),
                        ),
                        const Expanded(child: Gaps.empty),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.whatsapp,
                              size: 16, color: Colors.greenAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(1, record);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.message,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(3, record);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.call,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(2, record);
                          },
                        ),
                      ],
                    ),
                    // Gaps.vGap8,
                    Text(
                      record.body!,
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeUtils.getTextColor(context),
                      ),
                    ),
                    Gaps.vGap4,
                    Row(
                      children: [
                        const Expanded(child: Gaps.empty),
                        Text(
                          DateFormat('MMM d, yyyy hh:mm a', 'en_US').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  record.dateSent! * 1000)),
                          style:
                              TextStyle(fontSize: 10, color: ThemeUtils.getTextColor(context)),
                        ),
                        Gaps.hGap8
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// 模板项 Widget
class _TemplateItem extends StatelessWidget {
  const _TemplateItem({
    required this.template,
    required this.isExpanded,
    required this.onSelect,
    required this.onToggleExpand,
  });

  final CollectionLogOtherHJSmsTemplate template;
  final bool isExpanded;
  final VoidCallback onSelect;
  final VoidCallback onToggleExpand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onSelect,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        template.sName ?? 'Empty message.',
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.4,
                        ),
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 20,
                      ),
                      onPressed: onToggleExpand,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded && template.dTemplate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Message Details:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      template.dTemplate!,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
