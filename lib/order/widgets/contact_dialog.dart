import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/collection_log_entity.dart';
import '../../util/toast_utils.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({
    super.key,
    required this.collectionOrderId,
    required this.contactList,
    this.onSendSms,
    this.repayInfo,
    this.period,
  });
  final int collectionOrderId;
  final List<CollectionLogOtherContactInfo2Data> contactList;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;
  final CollectionLogOtherRepayInfo? repayInfo;
  final CollectionLogOtherPeriod? period;
  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  int _selectedIndex = -1;
  void _showSmsDialog(BuildContext context, int contactId, String phone) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SmsDialog(
          repayInfo: widget.repayInfo,
          onPressed: (templateId, smsContent) {
            widget.onSendSms?.call(templateId, smsContent,
                contactId: contactId, phone: phone);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6, top: 6),
      color: Colors.grey.shade200,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: ListView.builder(
          itemCount: widget.contactList.length,
          itemBuilder: (context, index) {
            return ContactCard(
              contact: widget.contactList[index],
              collectionOrderId: widget.collectionOrderId,
              repayInfo: widget.repayInfo,
              period: widget.period,
              selected: _selectedIndex == index,
              onCallOrSms: (int index, int type) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              contactIndex: index,
            );
          },
        ),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  final CollectionLogOtherContactInfo2Data contact;
  final int contactIndex;
  final void Function(int, int) onCallOrSms;
  final CollectionLogOtherRepayInfo? repayInfo;
  final int collectionOrderId;
  final bool selected;
  final CollectionLogOtherPeriod? period;
  ContactCard({
    required this.contact,
    required this.onCallOrSms,
    required this.contactIndex,
    required this.repayInfo,
    required this.collectionOrderId,
    required this.selected,
    required this.period,
  });

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> with WidgetsBindingObserver {
  DateTime? _appPausedTime;
  DateTime? _appResumedTime;
  bool _isWhatsAppLaunched = false;
  int? _currentTemplateId; // 存储当前选中的模板ID
  Timer? _cleanupTimer; // 清理定时器
  String? _lastActionSource; // 记录最后一次操作来源：'call', 'sms', 'whatsapp'

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
          if (_isWhatsAppLaunched && timeSpentOutside.inSeconds > 5) {
            _recordWhatsAppClick();
          }
          _isWhatsAppLaunched = false;
          _cleanupTimer?.cancel(); // 清理定时器
        }
        break;
      default:
        break;
    }
  }

  void _recordWhatsAppClick() async {
    // 记录WhatsApp点击事件到缓存
    print(
        'WhatsApp click recorded - user spent more than 5 seconds in WhatsApp');

    // 使用保存的模板ID记录点击事件
    final templateId = _currentTemplateId ?? 0;
    await Cache().appendToStringList('action_contact',
        '1:${widget.collectionOrderId}:${widget.contact.id}:$templateId');

    // 重置模板ID
    _currentTemplateId = null;
  }

  // 更新联系人价值状态
  void _updateContactValue(int newStatus) async {
    if (_lastActionSource == null) {
      return;
    }

    print('Updating contact value: $_lastActionSource -> $newStatus');

    // 根据来源更新相应的状态
    if (_lastActionSource == 'call') {
      // 更新电话状态
      widget.contact.aAAAAHLContactWeights?.qPhoneStatus = newStatus;
      showToast('Updated ${widget.contact.gPhone} phone status to: $newStatus');
    } else if (_lastActionSource == 'sms') {
      showToast('Updated ${widget.contact.gPhone} sms status to: $newStatus');
    } else if (_lastActionSource == 'whatsapp') {
      // 更新WhatsApp状态
      widget.contact.aAAAAHLContactWeights?.rWaStatus = newStatus;
      showToast(
          'Updated ${widget.contact.gPhone} WhatsApp status to: $newStatus');
    }

    // 记录价值更新到缓存
    await Cache().appendToStringList('contact_value_updates',
        '${widget.contact.id}:${widget.collectionOrderId}:$_lastActionSource:$newStatus:${DateTime.now().toIso8601String()}');

    // 触发UI更新
    setState(() {});

    // 重置操作来源
    _lastActionSource = null;
  }

  String formatDuration(int totalSeconds) {
    int minutes = totalSeconds ~/ 60; // Get the number of minutes
    int seconds = totalSeconds % 60; // Get the remaining seconds

    // Format the string based on the values
    if (minutes == 0) {
      return '$seconds sec';
    } else if (seconds == 0) {
      return '$minutes min';
    } else {
      return '$minutes min $seconds sec';
    }
  }

  int calculateCalendarDaysDifference(DateTime start, DateTime end) {
    // 将两个日期都设置为午夜时间，只比较日期部分
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);
    return end.difference(start).inDays;
  }

  Widget getIcon(String actionType) {
    if (actionType == 'call') {
      if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 10) {
        //未知
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 20) {
        //没有价值
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 30) {
        //有价值
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 40) {
        //十分有价值
        return const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
          size: 20,
        );
      }
    } else if (actionType == 'sms') {
      if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 10) {
        //未知
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 20) {
        //没有价值
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 30) {
        //有价值
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.qPhoneStatus == 40) {
        return const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
          size: 20,
        );
      }
    } else if (actionType == 'whatsapp') {
      if (widget.contact.aAAAAHLContactWeights?.rWaStatus == 10) {
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights?.rWaStatus == 20) {
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.rWaStatus == 30) {
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights?.rWaStatus == 40) {
        return const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
          size: 20,
        );
      }
    }
    return const SizedBox.shrink();
  }

  // 获取WhatsApp停留时间显示
  String getWhatsAppStayTime() {
    if (_appResumedTime == null || _appPausedTime == null) {
      return '';
    }

    final Duration timeSpentOutside =
        _appResumedTime!.difference(_appPausedTime!);
    if (timeSpentOutside.inSeconds > 5) {
      return 'Stayed ${timeSpentOutside.inSeconds}s';
    }
    return '';
  }

  // 获取上次点击时间
  String getLastClickTime(String actionType) {
    String? timeString;
    if (actionType == 'call') {
      timeString = widget.contact.aAAAAHLContactWeights?.eLastCallTime;
    } else if (actionType == 'sms') {
      timeString = widget.contact.aAAAAHLContactWeights?.uSmsLastAt;
    } else if (actionType == 'whatsapp') {
      timeString = widget.contact.aAAAAHLContactWeights?.vWaLastAt;
    }

    if (timeString == null || timeString.isEmpty) {
      return '';
    }

    try {
      final DateTime time = DateTime.parse(timeString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(time);

      if (difference.inDays > 0) {
        return '${difference.inDays} Days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} Hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} Minutes ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return timeString;
    }
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
      if (widget.contactIndex == 0) {
        if (overdueDays < 6) {
          return value['c_type'] == 26 &&
              (int.parse(value['e_days'] as String) == overdueDays ||
                  int.parse(value['e_days'] as String) == (overdueDays - 1) ||
                  int.parse(value['e_days'] as String) < -100);
        } else {
          return value['c_type'] == 26 &&
              (int.parse(value['e_days'] as String) > 2 ||
                  int.parse(value['e_days'] as String) < -100);
        }
      } else {
        if (overdueDays < 6) {
          return value['c_type'] == 28 &&
              (int.parse(value['e_days'] as String) == overdueDays ||
                  int.parse(value['e_days'] as String) == (overdueDays - 1) ||
                  int.parse(value['e_days'] as String) < -100);
        } else {
          return value['c_type'] == 28 &&
              (int.parse(value['e_days'] as String) > 2 ||
                  int.parse(value['e_days'] as String) < -100);
        }
      }
    }) // 先过滤原始数据
            .map((value) {
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
    Future<void> launchAction(int type) async {
      widget.onCallOrSms(widget.contactIndex, 1);

      // 记录操作来源
      if (type == 1) {
        _lastActionSource = 'whatsapp';
      } else if (type == 2) {
        _lastActionSource = 'call';
      } else if (type == 3) {
        _lastActionSource = 'sms';
      }

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
                            template.dTemplate! != ''
                                ? template.dTemplate!
                                : 'Custom message.',
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
            // 启动WhatsApp
            final bool result = await Utils.launchWhatsAppURL(
                '234${widget.contact.gPhone!}',
                message: selectedTemplate.dTemplate);
            if (result) {
              // 设置WhatsApp启动标志，等待用户返回应用
              _isWhatsAppLaunched = true;
              _currentTemplateId = selectedTemplate.id; // 保存模板ID
              print('WhatsApp launched, waiting for user to return...');

              // 启动清理定时器，30秒后自动清理状态
              _cleanupTimer?.cancel();
              _cleanupTimer = Timer(const Duration(seconds: 30), () {
                if (mounted) {
                  setState(() {
                    _isWhatsAppLaunched = false;
                    _currentTemplateId = null;
                  });
                }
              });
            }
          } else if (type == 3) {
            final String currentTime = DateTime.now().toIso8601String();
            final bool result = await launch(
                'sms:${widget.contact.gPhone}?body=${selectedTemplate.dTemplate}');
            if (result) {
              final String currentTime2 = DateTime.now().toIso8601String();
              if (DateTime.parse(currentTime2)
                      .difference(DateTime.parse(currentTime))
                      .inSeconds >
                  5) {
                await Cache().appendToStringList('action_contact',
                    '$type:${widget.collectionOrderId}:${widget.contact.id}:${selectedTemplate.id}');
              }
            }
          }
        }
      } else if (type == 2) {
        final String currentTime = DateTime.now().toIso8601String();
        final url = 'tel:${widget.contact.gPhone}';
        if (await canLaunch(url)) {
          final bool result = await launch(url);
          if (result) {
            final String currentTime2 = DateTime.now().toIso8601String();
            if (DateTime.parse(currentTime2)
                    .difference(DateTime.parse(currentTime))
                    .inSeconds >
                5) {
              await Cache().appendToStringList('action_contact',
                  '$type:${widget.collectionOrderId}:${widget.contact.id}:0');
            }
          }
        }
      }
    }

    return Card(
      shadowColor: Colors.blue,
      margin: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          ColoredBox(
            color: widget.selected
                ? const Color.fromARGB(255, 210, 234, 253)
                : Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 上面显示姓名和电话
                Row(
                  children: [
                    Icon(
                      widget.contactIndex == 0
                          ? Icons.radio_button_on
                          : Icons.group_outlined,
                      size: 20,
                      color: widget.contactIndex == 0
                          ? Colors.redAccent
                          : Colors.grey,
                    ),
                    Gaps.hGap8,
                    Text(
                      '${widget.contact.cRelation ?? ''} ${widget.contact.fName ?? ''}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.hGap4,
                    Expanded(
                      child: Gaps.empty,
                    ),
                    Text(
                      widget.contact.gPhone ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 163, 199, 247),
                      ),
                    ),
                  ],
                ),

                // 下面显示三列
                Row(
                  children: [
                    // 第一列：短信
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: 2,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: widget.contact.aAAAAHLContactWeights
                                                ?.lSmsCount !=
                                            null
                                        ? const Color.fromARGB(
                                            255, 236, 182, 180)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${widget.contact.aAAAAHLContactWeights?.lSmsCount ?? ""}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.message,
                                  size: 24,
                                  color: Colors.blue,
                                ),
                                onPressed: () => launchAction(3),
                              ),
                            ],
                          ),
                          Text(
                            getLastClickTime('sms'),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // 第二列：电话
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: 10,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: widget.contact.aAAAAHLContactWeights
                                                ?.dCallTimes !=
                                            null
                                        ? const Color.fromARGB(
                                            255, 236, 182, 180)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${widget.contact.aAAAAHLContactWeights?.dCallTimes ?? ""}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.call,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                onPressed: () => launchAction(2),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: getIcon('call'),
                              ),
                            ],
                          ),
                          Text(
                            getLastClickTime('call'),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // 第三列：WhatsApp
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: 2,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: widget.contact.aAAAAHLContactWeights
                                                ?.wWaCt !=
                                            null
                                        ? const Color.fromARGB(
                                            255, 236, 182, 180)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${widget.contact.aAAAAHLContactWeights?.wWaCt ?? ""}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                onPressed: () => launchAction(1),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: getIcon('whatsapp'),
                              ),
                            ],
                          ),
                          Text(
                            getLastClickTime('whatsapp'),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.selected ? _buildGoodsMenu(context) : Gaps.empty,
        ],
      ),
    );
  }

  Widget _buildGoodsMenu(BuildContext context) {
    return Positioned.fill(
      child: _buildGoodsMenuContent(context),
    );
  }

  Widget _buildGoodsMenuContent(BuildContext context) {
    final bool isDark = true;
    final Color buttonColor = isDark ? Colours.dark_text : Colors.white;

    return InkWell(
        onTap: () {},
        child: ColoredBox(
          color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyButton(
                key: Key('goods_edit_item_'),
                text: 'Non-Productive',
                fontSize: Dimens.font_sp10,
                radius: 24.0,
                minWidth: 56.0,
                minHeight: 56.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                backgroundColor: Colors.red,
                onPressed: () => _updateContactValue(20), // 20 = 没有价值
              ),
              MyButton(
                key: Key('goods_operation_item_'),
                text: 'Productive Lead',
                fontSize: Dimens.font_sp10,
                radius: 24.0,
                minWidth: 56.0,
                minHeight: 56.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                backgroundColor: Color.fromARGB(255, 161, 232, 162),
                onPressed: () => _updateContactValue(30), // 30 = 有价值
              ),
              MyButton(
                key: Key('goods_delete_item_'),
                text: 'High-Value Lead',
                fontSize: Dimens.font_sp10,
                radius: 24.0,
                minWidth: 56.0,
                minHeight: 56.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                backgroundColor: const Color.fromARGB(255, 2, 158, 7),
                onPressed: () => _updateContactValue(40), // 40 = 十分有价值
              ),
            ],
          ),
        ));
  }
}
