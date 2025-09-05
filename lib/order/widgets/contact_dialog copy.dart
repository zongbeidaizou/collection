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
    required this.showContactDays,
  });
  final int collectionOrderId;
  final List<CollectionLogOtherContactInfo2Data> contactList;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;
  final CollectionLogOtherRepayInfo? repayInfo;
  final CollectionLogOtherPeriod? period;
  final int showContactDays;
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
        child: Column(
          children: [
            if (widget.period != null &&
                widget.period!.lOverdueDays! < widget.showContactDays)
              Container(
                color: Colors.red,
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    'Will show contact overdue days: ${widget.showContactDays}'),
              )
            else
              Container(
                color: Colors.green[400],
                // width: double.infinity,
                // height: 30,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                child: Text(
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    'Label contacts to boost efficiency. Labels are permanent, private, and visible only to you.'),
              ),
            Gaps.vGap8,
            Expanded(
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
          ],
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
  bool selected;
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
    // 使用保存的模板ID记录点击事件
    final templateId = _currentTemplateId ?? 0;
    await Cache().appendToStringList('action_contact',
        '1:${widget.collectionOrderId}:${widget.contact.id}:$templateId');

    // 重置模板ID
    _currentTemplateId = null;
  }

  // 确保联系人权重对象存在
  void _ensureContactWeightsExists() {
    if (widget.contact.aAAAAHLContactWeights == null) {
      widget.contact.aAAAAHLContactWeights =
          CollectionLogOtherContactInfo2DataAAAAAHLContactWeights();
    }
  }

  // 根据数量返回显示文本
  String getDisplayText(int count) {
    if (count < 5) {
      return '1+';
    } else if (count < 10) {
      return '5+';
    } else {
      // 对于10及以上的数字，按10的倍数递增
      int base = ((count - 1) ~/ 10) * 10;
      return '${base}+';
    }
  }

  // 更新联系人列表中的状态并存储
  void _updateContactListInStorage(String fieldName, dynamic newValue) {
    final contactList =
        SpUtil.getObjectList("contact2List:${widget.collectionOrderId}")
            ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(
                e as Map<String, dynamic>))
            .toList();

    if (contactList != null && contactList.isNotEmpty) {
      // 更新contactList中id与widget.contact.id相同的对象的状态
      for (var contact in contactList) {
        if (contact.id == widget.contact.id) {
          // 确保 aAAAAHLContactWeights 存在
          contact.aAAAAHLContactWeights ??=
              CollectionLogOtherContactInfo2DataAAAAAHLContactWeights();

          // 根据字段名更新相应的状态
          if (fieldName == 'qPhoneStatus') {
            contact.aAAAAHLContactWeights!.qPhoneStatus = newValue as int;
          } else if (fieldName == 'rWaStatus') {
            contact.aAAAAHLContactWeights!.rWaStatus = newValue as int;
          } else if (fieldName == 'vWaLastAt') {
            contact.aAAAAHLContactWeights!.vWaLastAt = newValue as String;
            contact.aAAAAHLContactWeights!.wWaCt =
                contact.aAAAAHLContactWeights!.wWaCt! + 1;
          } else if (fieldName == 'eLastCallTime') {
            contact.aAAAAHLContactWeights!.eLastCallTime = newValue as String;
            contact.aAAAAHLContactWeights!.dCallTimes =
                contact.aAAAAHLContactWeights!.dCallTimes! + 1;
          } else if (fieldName == 'uSmsLastAt') {
            contact.aAAAAHLContactWeights!.uSmsLastAt = newValue as String;
            contact.aAAAAHLContactWeights!.lSmsCount =
                contact.aAAAAHLContactWeights!.lSmsCount! + 1;
          }
          Cache().appendToStringList('contactWeights',
              '${widget.contact.id}#${fieldName}#${newValue}');
          break;
        }
      }

      // 重新存储contactList
      SpUtil.putObjectList(
          "contact2List:${widget.collectionOrderId}", contactList);
    }
  }

  // 更新联系人价值状态
  void _updateContactValue(int newStatus) async {
    if (_lastActionSource == null) {
      return;
    }

    print('Updating contact value: $_lastActionSource -> $newStatus');

    // 确保 aAAAAHLContactWeights 存在
    _ensureContactWeightsExists();
    print(
        'Ensured aAAAAHLContactWeights exists for contact ${widget.contact.id}');

    // 根据来源更新相应的状态
    if (_lastActionSource == 'call') {
      // 更新电话状态
      widget.contact.aAAAAHLContactWeights!.qPhoneStatus = newStatus;
      _updateContactListInStorage('qPhoneStatus', newStatus);
    } else if (_lastActionSource == 'sms') {
      // 短信也更新电话状态（因为使用同一个字段）
      widget.contact.aAAAAHLContactWeights!.qPhoneStatus = newStatus;
      _updateContactListInStorage('qPhoneStatus', newStatus);
    } else if (_lastActionSource == 'whatsapp') {
      // 更新WhatsApp状态
      widget.contact.aAAAAHLContactWeights!.rWaStatus = newStatus;
      _updateContactListInStorage('rWaStatus', newStatus);
    }
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

  // 手机号码脱敏函数：隐藏第3、4、5位数字
  String maskPhoneNumber(String phone) {
    if (phone.isEmpty || phone.length < 6) {
      return phone;
    }

    // 将手机号码转换为字符数组
    List<String> phoneChars = phone.split('');

    // 隐藏第3、4、5位数字（索引为2、3、4）
    // 注意：索引从0开始，所以第3位是索引2，第4位是索引3，第5位是索引4
    if (phoneChars.length > 2) phoneChars[2] = '*';
    if (phoneChars.length > 3) phoneChars[3] = '*';
    if (phoneChars.length > 4) phoneChars[4] = '*';

    return phoneChars.join();
  }

  int calculateCalendarDaysDifference(DateTime start, DateTime end) {
    // 将两个日期都设置为午夜时间，只比较日期部分
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);
    return end.difference(start).inDays;
  }

  Widget getIcon(String actionType) {
    // 如果 aAAAAHLContactWeights 不存在，返回空组件
    if (widget.contact.aAAAAHLContactWeights == null) {
      return const SizedBox.shrink();
    }

    if (actionType == 'call') {
      if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 10) {
        //未知
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 20) {
        //没有价值
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 30) {
        //有价值
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 40) {
        //十分有价值
        return const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
          size: 20,
        );
      }
    } else if (actionType == 'sms') {
      if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 10) {
        //未知
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 20) {
        //没有价值
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 30) {
        //有价值
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.qPhoneStatus == 40) {
        return const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
          size: 20,
        );
      }
    } else if (actionType == 'whatsapp') {
      if (widget.contact.aAAAAHLContactWeights!.rWaStatus == 10) {
        return const SizedBox.shrink();
      } else if (widget.contact.aAAAAHLContactWeights!.rWaStatus == 20) {
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.rWaStatus == 30) {
        return const Icon(
          Icons.done,
          color: Color.fromARGB(255, 10, 238, 14),
          size: 16,
        );
      } else if (widget.contact.aAAAAHLContactWeights!.rWaStatus == 40) {
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
    // 如果 aAAAAHLContactWeights 不存在，返回空字符串
    if (widget.contact.aAAAAHLContactWeights == null) {
      return '';
    }

    String? timeString;
    if (actionType == 'call') {
      timeString = widget.contact.aAAAAHLContactWeights!.eLastCallTime;
    } else if (actionType == 'sms') {
      timeString = widget.contact.aAAAAHLContactWeights!.uSmsLastAt;
    } else if (actionType == 'whatsapp') {
      timeString = widget.contact.aAAAAHLContactWeights!.vWaLastAt;
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
          bool isMatch = value['c_type'] == 28 &&
              (int.parse(value['e_days'] as String) == overdueDays ||
                  int.parse(value['e_days'] as String) == (overdueDays - 1) ||
                  int.parse(value['e_days'] as String) < -100);
          print('isMatch: $isMatch');
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
    templates2.sort((a, b) => a.eDays!.compareTo(b.eDays!));
    Future<void> launchAction(int type) async {
      //type 1:whatsapp 2:call 3:sms
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
              // 更新WhatsApp最后访问时间
              final currentTime = DateTime.now().toIso8601String();
              _ensureContactWeightsExists();
              widget.contact.aAAAAHLContactWeights!.vWaLastAt = currentTime;
              // 同时更新存储中的联系人列表
              _updateContactListInStorage('vWaLastAt', currentTime);
              setState(() {});
            }
          } else if (type == 3) {
            final bool result = await launch(
                'sms:${widget.contact.gPhone}?body=${selectedTemplate.dTemplate}');
            if (result) {
              // 更新SMS最后访问时间
              final currentTime = DateTime.now().toIso8601String();
              _ensureContactWeightsExists();
              widget.contact.aAAAAHLContactWeights!.uSmsLastAt = currentTime;
              _updateContactListInStorage('uSmsLastAt', currentTime);
              setState(() {});

              await Cache().appendToStringList('action_contact',
                  '$type:${widget.collectionOrderId}:${widget.contact.id}:${selectedTemplate.id}');
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
              // 更新Call最后访问时间
              _ensureContactWeightsExists();
              widget.contact.aAAAAHLContactWeights!.eLastCallTime =
                  currentTime2;
              _updateContactListInStorage('eLastCallTime', currentTime2);
              setState(() {});

              await Cache().appendToStringList('action_contact',
                  '$type:${widget.collectionOrderId}:${widget.contact.id}:0');
            }
          }
        }
      }
    }

    return Card(
      shadowColor: Colors.blue,
      margin: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          ColoredBox(
            color: widget.selected
                ? const Color.fromARGB(255, 210, 234, 253)
                : Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
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
                      size: 16,
                      color: widget.contactIndex == 0
                          ? Colors.redAccent
                          : Colors.grey,
                    ),
                    Gaps.hGap8,
                    Expanded(
                      flex: 6,
                      child: Text(
                          '${widget.contact.cRelation ?? ''} ${widget.contact.fName ?? ''}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Gaps.hGap4,
                    Expanded(
                      child: Gaps.empty,
                    ),
                    Text(
                      maskPhoneNumber(widget.contact.gPhone ?? ''),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 163, 199, 247),
                      ),
                    ),
                  ],
                ),

                // 下面显示三列
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 第一列：短信
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  color: widget.contact.aAAAAHLContactWeights
                                                  ?.lSmsCount !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .lSmsCount! >
                                              0
                                      ? const Color.fromARGB(255, 236, 182, 180)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.contact.aAAAAHLContactWeights
                                                  ?.lSmsCount !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .lSmsCount! >
                                              0
                                      ? getDisplayText(widget.contact
                                          .aAAAAHLContactWeights!.lSmsCount!)
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Gaps.hGap8,
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.message,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => launchAction(3),
                                ),
                              ),
                              Gaps.hGap8,
                              getIcon('call'),
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
                        ],
                      ),
                    ),

                    // 第二列：电话
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  color: widget.contact.aAAAAHLContactWeights
                                                  ?.dCallTimes !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .dCallTimes! >
                                              0
                                      ? const Color.fromARGB(255, 236, 182, 180)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.contact.aAAAAHLContactWeights
                                                  ?.dCallTimes !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .dCallTimes! >
                                              0
                                      ? getDisplayText(widget.contact
                                          .aAAAAHLContactWeights!.dCallTimes!)
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Gaps.hGap8,
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.call,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => launchAction(2),
                                ),
                              ),
                              Gaps.hGap8,
                              getIcon('call'),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  color: widget.contact.aAAAAHLContactWeights
                                                  ?.wWaCt !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .wWaCt! >
                                              0
                                      ? const Color.fromARGB(255, 236, 182, 180)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.contact.aAAAAHLContactWeights?.wWaCt !=
                                              null &&
                                          widget.contact.aAAAAHLContactWeights!
                                                  .wWaCt! >
                                              0
                                      ? getDisplayText(widget.contact
                                          .aAAAAHLContactWeights!.wWaCt!)
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Gaps.hGap8,
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => launchAction(1),
                                ),
                              ),
                              Gaps.hGap8,
                              getIcon('whatsapp'),
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
        onTap: () {
          widget.selected = false;
          setState(() {});
        },
        child: ColoredBox(
          color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyButton(
                  key: Key('goods_edit_item_'),
                  icon: Icons.close,
                  text: 'Unreachable or Unacquainted',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _updateContactValue(20); // 20 = 没有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        ' This contact is not registered, the number is invalid, or they do not know the borrower.',
                        backgroundColor: Colors.red,
                        position: ToastPosition.center,
                        duration: Duration(seconds: 2));
                  },
                ),
                MyButton(
                  key: Key('goods_delete_item_'),
                  icon: Icons.done_all_rounded,
                  text: 'Confirms Knowing Borrower',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: const Color.fromARGB(255, 2, 158, 7),
                  onPressed: () {
                    _updateContactValue(40); // 40 = 十分有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        'This contact knows the borrower, which is beneficial for future debt collection efforts.',
                        backgroundColor: Colors.green,
                        position: ToastPosition.center,
                        duration: Duration(seconds: 2));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
