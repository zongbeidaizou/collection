import 'package:bounty_hunter/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactDialog extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: '张三', relationship: '朋友', phoneNumber: '1234567890'),
    Contact(name: '李四', relationship: '家人', phoneNumber: '0987654321'),
    Contact(name: '王五', relationship: '同事', phoneNumber: '1122334455'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:6, right: 6, top:6),
      color: Colors.grey.shade200,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          ),
        child:ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ContactCard(contact: contacts[index]);
          },
        )
      ),
    );
  }
}

class Contact {
  final String name;
  final String relationship;
  final String phoneNumber;

  Contact({required this.name, required this.relationship, required this.phoneNumber});
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard({required this.contact});

  void _callContact() async {
    final url = 'tel:${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '无法拨打电话';
    }
  }

  void _sendSms() async {
    final url = 'sms:${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '无法发送短信';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Gaps.hGap12,
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: contact.name),
                TextSpan(text: contact.relationship),
              ],
            ),
          ),
          Expanded(child: Gaps.hGap2),
          IconButton(
            icon: Icon(Icons.call, size: 20,),
            onPressed: _callContact,
          ),
          IconButton(
            icon: Icon(Icons.message, size: 20,),
            onPressed: _sendSms,
          ),
        ],
      ),
    );
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(contact.name),
        subtitle: Text(contact.relationship),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.call),
              onPressed: _callContact,
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: _sendSms,
            ),
          ],
        ),
      ),
    );
  }
}