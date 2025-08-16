import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/util/other_utils.dart';
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
  });
  final int collectionOrderId;
  final List<SGContactData> contactList;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;
  final CollectionLogOtherRepayInfo? repayInfo;

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
              bgColor: _selectedIndex == index
                  ? const Color.fromARGB(255, 210, 234, 253)
                  : Colors.transparent,
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

class ContactCard extends StatelessWidget {
  final SGContactData contact;
  final int contactIndex;
  final Color bgColor;
  final void Function(int, int) onCallOrSms;
  final CollectionLogOtherRepayInfo? repayInfo;
  final int collectionOrderId;

  ContactCard({
    required this.contact,
    required this.onCallOrSms,
    required this.bgColor,
    required this.contactIndex,
    required this.repayInfo,
    required this.collectionOrderId,
  });

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

  // 获取WhatsApp状态文本
  String getWhatsAppStatus() {
    // 这里可以根据实际业务逻辑返回状态
    // 示例：未注册、不认识借款人、认识借款人
    if (contact.hReviewResult == 1) {
      return '认识借款人';
    } else if (contact.hReviewResult == 2) {
      return '不认识借款人';
    } else if (contact.hReviewResult == 3) {
      return '未注册';
    }
    return '未知';
  }

  // 获取电话状态文本
  String getPhoneStatus() {
    // 这里可以根据实际业务逻辑返回状态
    // 示例：无法拨通、不认识借款人、认识借款人
    if (contact.hReviewResult == 1) {
      return '认识借款人';
    } else if (contact.hReviewResult == 2) {
      return '不认识借款人';
    } else if (contact.hReviewResult == 3) {
      return '无法拨通';
    }
    return '未知';
  }

  // 获取上次点击时间
  String getLastClickTime(String actionType) {
    // 这里可以从缓存或数据库中获取上次点击时间
    // 示例实现，实际应该从数据源获取
    return '2024-01-15 14:30';
  }

  @override
  Widget build(BuildContext context) {
    final int overdueDays = calculateCalendarDaysDifference(
        DateTime.parse(repayInfo!.expectRepayTime!), DateTime.now());
    final List<Map<String, dynamic>> dataList =
        SpUtil.getObjectList('hJSmsTemplates')!.cast<Map<String, dynamic>>();
    // 先过滤e_days为1的元素，再进行后续处理
    final List<CollectionLogOtherHJSmsTemplate> templates2 =
        List<CollectionLogOtherHJSmsTemplate>.from(dataList.where((value) {
      if (contactIndex == 0) {
        return value['c_type'] == 26 &&
            (int.parse(value['e_days'] as String) == overdueDays ||
                int.parse(value['e_days'] as String) == (overdueDays - 1) ||
                int.parse(value['e_days'] as String) > 900);
      } else {
        return value['c_type'] == 28 &&
            (overdueDays > 0 || int.parse(value['e_days'] as String) > 900);
      }
    }) // 先过滤原始数据
            .map((value) {
      final template = $CollectionLogOtherHJSmsTemplateFromJson(value);
      // 替换所有占位符

      String processedTemplate = template.dTemplate!
          .replaceAll('@expect_repay_amount@', repayInfo!.expectRepayAmount!)
          .replaceAll(
              '@expect_repay_time@',
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(repayInfo!.expectRepayTime!)))
          .replaceAll('@overdue_days@', repayInfo!.overdueDays.toString())
          .replaceAll('@mobile@', repayInfo!.mobile!)
          .replaceAll('@phone@', repayInfo!.phone!)
          .replaceAll('@bvn@', repayInfo!.bvn!)
          .replaceAll('@name@', repayInfo!.name!)
          .replaceAll('@borrow_amount@', repayInfo!.borrowAmount!)
          .replaceAll('@loan_amount@', repayInfo!.loanAmount!)
          .replaceAll('@borrow_days@', repayInfo!.borrowDays.toString())
          .replaceAll('@app_name@', repayInfo!.appName!)
          .replaceAll('@url@', repayInfo!.url!)
          .replaceAll('@product_name@', repayInfo!.productName!)
          .replaceAll('@loan_time@', repayInfo!.loanTime!)
          .replaceAll('@receive_bank@', repayInfo!.receiveBank!)
          .replaceAll('@receive_bank_no@', repayInfo!.receiveBankNo!)
          .replaceAll('@account_name@', repayInfo!.accountName!)
          .replaceAll('@account_no@', repayInfo!.accountNo!)
          .replaceAll('@account_bank@', repayInfo!.accountBank!)
          .replaceAll('@before_credit_amount@', repayInfo!.beforeCreditAmount!)
          .replaceAll('@after_credit_amount@', repayInfo!.afterCreditAmount!)
          .replaceAll('@change_credit_amount@', repayInfo!.changeCreditAmount!)
          .replaceAll(
              '@before_credit_fraction@', repayInfo!.beforeCreditFraction!)
          .replaceAll(
              '@after_credit_fraction@', repayInfo!.afterCreditFraction!)
          .replaceAll(
              '@change_credit_fraction@', repayInfo!.changeCreditFraction!)
          .replaceAll('@var1@', repayInfo!.var1!)
          .replaceAll('@var2@', repayInfo!.var2!)
          .replaceAll('@var3@', repayInfo!.var3!)
          .replaceAll('@var4@', repayInfo!.var4!)
          .replaceAll('@var5@', repayInfo!.var5!)
          .replaceAll('@var6@', repayInfo!.var6!)
          .replaceAll('@var7@', repayInfo!.var7!)
          .replaceAll('@var8@', repayInfo!.var8!)
          .replaceAll('@var9@', repayInfo!.var9!)
          .replaceAll('@var10@', repayInfo!.var10!);

      return template.copyWith(dTemplate: processedTemplate);
    })).toList();
    Future<void> launchAction(int type) async {
      onCallOrSms(contactIndex, 1);
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
            await Cache().appendToStringList('action_contact',
                '$type:$collectionOrderId:${contact.id}:${selectedTemplate.id}');
            Utils.launchWhatsAppURL('234${contact.gPhone!}',
                message: selectedTemplate.dTemplate);
          } else if (type == 3) {
            await Cache().appendToStringList('action_contact',
                '$type:$collectionOrderId:${contact.id}:${selectedTemplate.id}');
            launch('sms:${contact.gPhone}?body=${selectedTemplate.dTemplate}');
          }
        }
      } else if (type == 2) {
        await Cache().appendToStringList(
            'action_contact', '$type:$collectionOrderId:${contact.id}:0');
        final url = 'tel:${contact.gPhone}';
        if (await canLaunch(url)) {
          await launch(url);
        }
      }
    }

    return Card(
      shadowColor: Colors.blue,
      margin: const EdgeInsets.all(4.0),
      child: ColoredBox(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 上面显示姓名和电话
              Row(
                children: [
                  Icon(
                    contactIndex == 0
                        ? Icons.radio_button_on
                        : contact.hReviewResult == 1
                            ? Icons.group_outlined
                            : contact.hReviewResult == 2
                                ? Icons.group_off_outlined
                                : contact.hReviewResult == 3
                                    ? Icons.phone_disabled_outlined
                                    : Icons.perm_contact_cal,
                    size: 20,
                    color: contactIndex == 0
                        ? Colors.redAccent
                        : contact.hReviewResult == 1
                            ? Colors.green
                            : contact.hReviewResult == 2
                                ? Colors.orange
                                : contact.hReviewResult == 3
                                    ? Colors.red
                                    : Colors.grey,
                  ),
                  Gaps.hGap8,
                  Text(
                    '${contact.cRelation ?? ''} ${contact.fName ?? ''}',
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
                    contact.gPhone ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
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
                        IconButton(
                          icon: const Icon(
                            Icons.message,
                            size: 24,
                            color: Colors.blue,
                          ),
                          onPressed: () => launchAction(3),
                        ),
                        Text(
                          '短信',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gaps.vGap4,
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
                        IconButton(
                          icon: const Icon(
                            Icons.call,
                            size: 24,
                            color: Colors.blue,
                          ),
                          onPressed: () => launchAction(2),
                        ),
                        Text(
                          getPhoneStatus(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gaps.vGap4,
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
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 24,
                            color: Colors.green,
                          ),
                          onPressed: () => launchAction(1),
                        ),
                        Gaps.vGap4,
                        Text(
                          getWhatsAppStatus(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          getLastClickTime('whatsapp'),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 显示通话记录（如果有的话）
              if (contact.aAAAANIAdminRecordings != null &&
                  contact.aAAAANIAdminRecordings!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '通话记录:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gaps.vGap8,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 6.0,
                          mainAxisExtent: 24,
                        ),
                        itemCount: contact.aAAAANIAdminRecordings!.length,
                        itemBuilder: (context, index) {
                          final record = contact.aAAAANIAdminRecordings![index];
                          final numberIcons = [
                            Icons.looks_one_outlined,
                            Icons.looks_two_outlined,
                            Icons.looks_3_outlined,
                            Icons.looks_4_outlined,
                            Icons.looks_5_outlined,
                          ];

                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (index < numberIcons.length)
                                Icon(
                                  numberIcons[index],
                                  size: 10,
                                  color: Colors.grey,
                                )
                              else
                                Text(
                                  '${index + 1}.',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  DateFormat('MMM d, hh:mm', 'en_US')
                                      .format(DateTime.parse(record.kCallAt!)),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
