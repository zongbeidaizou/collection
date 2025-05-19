import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/collection_log_entity.dart';
import '../../util/toast_utils.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({
    super.key,
    required this.contactList,
    this.onSendSms,
    this.repayInfo,
  });
  final List<CollectionLogOtherContactInfo> contactList;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;
  final CollectionLogOtherRepayInfo? repayInfo;

  void _showSmsDialog(BuildContext context, int contactId, String phone) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SmsDialog(
          repayInfo:repayInfo,
          onPressed: (templateId, smsContent) {
            onSendSms?.call(templateId, smsContent, contactId: contactId, phone: phone);
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
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return ContactCard(contact: contactList[index], onSendSms: (int contactId, String phone){
              _showSmsDialog(context, contactId, phone);
            }, contactIndex: index,);
          },
        ),
      ),
    );
  }
}



class ContactCard extends StatelessWidget {
  final CollectionLogOtherContactInfo contact;
  final int contactIndex;

  ContactCard({required this.contact,required this.onSendSms, required this.contactIndex,});
  final void Function(int, String) onSendSms;

  void _callContact() async {
    final url = 'tel:${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'cant launch $url';
    }
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

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Gaps.hGap12,
              Icon(Icons.perm_contact_cal, size: 20, color: contactIndex == 0 ? Colors.redAccent : Colors.blueAccent.shade100),
              Gaps.hGap10,
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(text: contact.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const TextSpan(text: '  relationship: ', style: TextStyle(color: Colors.grey)),
                    TextSpan(text: contact.relationship, style: TextStyle(color: contactIndex == 0 ? Colors.red : Colors.grey)),
                  ],
                ),
              ),
              Expanded(child: Gaps.hGap2),
              IconButton(
                icon: Icon(Icons.call, size: 20, color: Colors.blueAccent),
                onPressed: _callContact,
              ),
              IconButton(
                icon: Icon(Icons.message, size: 20, color: Colors.greenAccent),
                onPressed: () => onSendSms.call(contact.id!, contact.phoneNumber!),
              ),
            ],
          ),
          Divider(thickness: 1.2,),
          if (contact.callRecords != null && contact.callRecords!.isNotEmpty) // 检查是否有通话记录
            Container(
              height: 100, // 固定高度
              padding: EdgeInsets.only(top: 6),
              child: ListView.builder(
                itemCount: contact.callRecords!.length,
                itemBuilder: (context, index) {
                  final record = contact.callRecords![index];
                  return Row(
                    children: [
                      Gaps.hGap12,
                      Icon(Icons.access_time_filled_sharp, size: 12, color: Colors.blueGrey.withOpacity(0.6)),
                      Gaps.hGap4,
                      Expanded(child: Text(DateFormat('MMM d, yyyy hh:mm a', 'en_US').format(DateTime.parse(record.time!)), style: TextStyle(fontSize: 12),),flex: 2,),
                      Icon(Icons.timelapse, size: 18, color: Colors.blueGrey.withOpacity(0.6)),
                      Gaps.hGap4,
                      Expanded(child: Text(formatDuration(record.duration!), style: TextStyle(fontSize: 12))),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}