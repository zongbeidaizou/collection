import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/widgets.dart';

import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../widgets/my_card.dart';
import 'MyCommentBox.dart';
import 'order_item.dart';

void main() {
  runApp(AddNote());
}

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<dynamic> filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to codeI love to codeI love to codeI love to codeI love to codeI love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(List<dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, int i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Gaps.line),
                    Text(data[i]['date'].toString(), style: TextStyle(fontSize: 10)),
                    Gaps.hGap8,
                    Icon(Icons.phone_disabled, color: Colors.purpleAccent, size: 12,),
                    Expanded(child: Gaps.line),
                  ],
                ),
                Gaps.vGap4,
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(data[i]['message'].toString())),
                Gaps.vGap4,
                // Gaps.line,
                Gaps.vGap8
              ],);
          }
      )

/*      ListView(
        children: [
          for (var i = 0; i < data.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Expanded(flex: 10,child: Gaps.line),
                  Text(data[i]['date'].toString(), style: TextStyle(fontSize: 10)),
                  Expanded(child: Gaps.line),
                  Icon(Icons.phone_disabled, color: Colors.purpleAccent, size: 12,),
                  Expanded(flex: 10,child: Gaps.line),
                ],
              ),
                Gaps.vGap4,
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(data[i]['message'].toString())),
                Gaps.vGap4,
                // Gaps.line,
                Gaps.vGap8
            ],)
        ],
      ),*/
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                // child: OrderItem(key: Key('order_item_'), index: 1, tabIndex: 1,inList: false,)
            ),
            // Text("My Collection Log"),
            Gaps.vGap4,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                child: MyCard(
                  shadowColor: Colors.grey.withOpacity(0.2),
                  child: MyCommentBox(
                    child: commentChild(filedata),
                    labelText: 'Write a comment...',
                    errorText: 'Comment cannot be blank',
                    withBorder: false,
                    sendButtonMethod: () {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        setState(() {
                          var value = {
                            'name': 'New User',
                            'pic':
                            'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                            'message': commentController.text,
                            'date': '2021-01-01 12:00:00'
                          };
                          filedata.insert(0, value);
                        });
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      } else {
                        print("Not validated");
                      }
                    },
                    formKey: formKey,
                    commentController: commentController,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    sendWidget: Icon(Icons.send_sharp, size: 28, color: Colours.app_main),
                  ),
                ),
              ),
            ),
            Gaps.line,
          ],
        ),
      ),
    );
  }

}