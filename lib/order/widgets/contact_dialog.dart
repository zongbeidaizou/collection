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

  @override
  Widget build(BuildContext context) {
    final int overdueDays = calculateCalendarDaysDifference(
        DateTime.parse(repayInfo!.expectRepayTime!), DateTime.now());
    final List<Map<String, dynamic>> dataList =
        SpUtil.getObjectList('hJSmsTemplates')!.cast<Map<String, dynamic>>();
    // 先过滤e_days为1的元素，再进行后续处理
    final List<CollectionLogOtherHJSmsTemplate> templates2 =
        List<CollectionLogOtherHJSmsTemplate>.from(dataList
            .where(
                (value) => int.parse(value['e_days'] as String) <= overdueDays)
            .where((value) {
      if (contactIndex == 0) {
        return value['c_type'] == 26;
      } else {
        return value['c_type'] == 28;
      }
    }) // 先过滤原始数据
            .map((value) {
      final template = $CollectionLogOtherHJSmsTemplateFromJson(value);
      // 替换所有占位符
      String processedTemplate = template.dTemplate!
          .replaceAll('@name@', repayInfo!.name!)
          .replaceAll('@phone@', repayInfo!.phone!)
          .replaceAll('@bvn@', repayInfo!.bvn!)
          .replaceAll(
              '@expect_repay_time@',
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(repayInfo!.expectRepayTime!)))
          .replaceAll('@expect_repay_amount@', repayInfo!.expectRepayAmount!)
          .replaceAll('@overdue_days@', repayInfo!.overdueDays.toString())
          .replaceAll('@mobile@', repayInfo!.mobile!)
          .replaceAll('@borrow_amount@', repayInfo!.borrowAmount!)
          .replaceAll('@loan_amount@', repayInfo!.loanAmount!)
          .replaceAll('@borrow_days@', repayInfo!.borrowDays.toString())
          .replaceAll('@account_no@', repayInfo!.accountNo!)
          .replaceAll('@account_bank@', repayInfo!.accountBank!);
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
                            template.dTemplate!,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Gaps.hGap12,
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
                          Gaps.hGap2,
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '${contact.cRelation ?? ''} ${contact.fName ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                // const TextSpan(text: '  relationship: ', style: TextStyle(color: Colors.grey)),
                                // TextSpan(text: contact.relationship, style: TextStyle(color: contactIndex == 0 ? Colors.red : Colors.grey)),
                              ],
                            ),
                          ),
                          const Expanded(child: Gaps.hGap2),
                          if (contact.lSmsCount != null &&
                              contact.lSmsCount! > 0 &&
                              contact.lSmsCount! != 999)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${contact.lSmsCount} SMS',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.blueAccent),
                              ),
                            ),
                          if (contact.nCallCount != null &&
                              contact.nCallCount! > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${contact.nCallCount} Calls',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.blueAccent),
                              ),
                            ),
                        ],
                      ),
                      // if (contact.nCallCount != null && contact.nCallCount! > 0)
                      //   Row(
                      //     children: [
                      //       Gaps.hGap12,
                      //       const Icon(
                      //         Icons.history,
                      //         size: 20,
                      //         color: Colors.blueAccent,
                      //       ),
                      //       Gaps.hGap10,
                      //       Text(
                      //           '${contact.nCallCount} Calls,',
                      //           style: const TextStyle(
                      //               fontSize: 12, color: Colors.blueAccent),
                      //         ),
                      //         Gaps.hGap10,
                      //         Text(
                      //           'Last call: ${DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(contact.eLastCallTime!))}',
                      //           style: const TextStyle(
                      //               fontSize: 12, color: Colors.blueAccent),
                      //         ),
                      //     ],
                      //   )
                      // else
                      //   Gaps.empty,
                    ],
                  ),
                ),
                Row(children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp,
                        size: 16, color: Colors.greenAccent),
                    onPressed: () => launchAction(1),
                  ),
                  IconButton(
                    icon: const Icon(Icons.message,
                        size: 16, color: Colors.blueAccent),
                    // onPressed: () => onSendSms.call(contact.id!, contact.gPhone!),
                    onPressed: () => launchAction(3),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call,
                        size: 16, color: Colors.blueAccent),
                    onPressed: () => launchAction(2),
                  ),
                ])
              ],
            ),
            if (contact.aAAAANIAdminRecordings != null &&
                contact.aAAAANIAdminRecordings!.isNotEmpty) // 检查是否有通话记录
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: const BoxConstraints(minHeight: 20), // 调整最小高度
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 6.0, // 增加垂直间距
                    mainAxisExtent: 24, // 明确设置每个item的高度
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
                      // ...其他图标
                    ];

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index < numberIcons.length)
                          Icon(
                            numberIcons[index],
                            size: 10, // 调整图标尺寸
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
                        const SizedBox(width: 4), // 增加间距
                        Expanded(
                          // 添加弹性布局
                          child: Text(
                            DateFormat('MMM d, hh:mm', 'en_US')
                                .format(DateTime.parse(record.kCallAt!)),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis, // 添加溢出处理
                            ),
                          ),
                        ),
                      ],
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
