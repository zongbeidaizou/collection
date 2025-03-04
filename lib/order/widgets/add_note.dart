import 'package:bounty_hunter/models/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../models/admin_entity.dart';
import '../../models/json/collection_log_entity.dart';
import '../../mvp/base_page.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../util/change_notifier_manage.dart';
import '../../widgets/my_card.dart';
import '../iview/add_note_iview.dart';
import '../presenter/add_note_presenter.dart';
import 'MyCommentBox.dart';
import 'order_item.dart';

void main() {
}

class AddNote extends StatefulWidget {
  const AddNote({
    super.key,
    required this.orderId,
    required this.admins,
  });
  final int orderId;
  final List<AdminData> admins;
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with AutomaticKeepAliveClientMixin<AddNote>,  BasePageMixin<AddNote, AddNotePresenter>
    implements AddNoteIMvpView   {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  List<CollectionLogData> _list = <CollectionLogData>[];
  final List<IconData> _iconList = [Icons.sync,Icons.sync, Icons.more_time, Icons.do_not_touch, Icons.phone_disabled, Icons.hourglass_disabled, Icons.payment];
  final List<Color> _colorList = [Colors.grey,Colors.grey, Colors.green, Colors.purpleAccent, Colors.red, Colors.orange, Colors.blue];
  late AddNotePresenter _addNotePresenter;

  Future<void> _onRefresh() async {
    _list = await _addNotePresenter.index(1, widget.orderId, true);
    setState(() {
    });
  }


  @override
  AddNotePresenter createPresenter() {
    _addNotePresenter = AddNotePresenter();
    return _addNotePresenter;
  }

  @override
  void onRefresh() {
    _onRefresh();
  }

  @override
  void setLogs(List<CollectionLogData> logs) {
    setState(() {
      _list = logs;
    });
  }

  @override
  bool get wantKeepAlive => true;

  Widget commentChild(List<CollectionLogData> data) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, int i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Expanded(child: Gaps.line),
                //     Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(data[i].createdAt!)), style: TextStyle(fontSize: 10)),
                //     Gaps.hGap8,
                //     Text( widget.admins.firstWhere((admin) => admin.id == data[i].eCollectionAdminId).aName ?? 'You' , style: const TextStyle(fontSize: 10)),
                //     Gaps.hGap8,
                //     Icon(_iconList[data[i].gType!], color: _colorList[data[i].gType!], size: 12,),
                //     Expanded(child: Gaps.line),
                //   ],
                // ),
                Gaps.vGap4,
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    decoration: BoxDecoration(
                      color: _colorList[data[i].gType!].withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(DateFormat("MMM dd, yyyy 'at' HH:mm").format(DateTime.parse(data[i].createdAt!)), style: TextStyle(fontSize: 10)),
                            Gaps.hGap8,
                            Text( 'Recorded by: ' , style: TextStyle(fontSize: 10, color: Colors.grey.withOpacity(0.8))),
                            Text( widget.admins.firstWhere((admin) => admin.id == data[i].eCollectionAdminId).aName ?? 'You' , style: TextStyle(fontSize: 10, color: Colors.grey.withOpacity(0.8))),
                            Gaps.hGap8,
                            Expanded(child: Gaps.empty),
                            Icon(_iconList[data[i].gType!], color: _colorList[data[i].gType!], size: 12,),
                          ],
                        ),
                        Gaps.vGap4,
                        Text(data[i].jContent.toString()),
                        Gaps.vGap4,
                        if ((data[i].kPromiseTime?.isNotEmpty ?? false) && data[i].gType! == 2) Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Promise to Pay by ${DateFormat("MMM dd, yyyy 'at' HH:mm").format(DateTime.parse(data[i].kPromiseTime!))}', style: TextStyle(fontSize: 10, color: Colors.grey.withOpacity(0.8))),
                          ],
                        ) else Gaps.empty,

                      ],
                    )),
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
                    child: commentChild(_list),
                    labelText: 'Write a comment...',
                    errorText: 'Comment cannot be blank',
                    withBorder: false,
                    sendButtonMethod: () async {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        print(dateController.text);
                        print(typeController.text);
                        var value = {
                          'g_type': typeController.text,
                          'j_content': commentController.text,
                          'created_at': DateTime.now(),
                          'e_collection_admin_id': 0,
                          'k_promise_time': dateController.text,
                        };
                        setState(() {
                          _list.insert(0, CollectionLogData.fromJson(value));
                        });
                        print(value);
                        await _addNotePresenter.store(value,  true);
                        commentController.clear();
                        dateController.clear();
                        typeController.clear();
                        FocusScope.of(context).unfocus();
                      } else {
                        print("Not validated");
                      }
                    },
                    formKey: formKey,
                    commentController: commentController,
                    dateController: dateController,
                    typeController: typeController,
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