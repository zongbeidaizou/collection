import 'package:bounty_hunter/models/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../mvp/base_page.dart';
import '../../res/colors.dart';
import '../../res/dimens.dart';
import '../../res/gaps.dart';
import '../../routers/fluro_navigator.dart';
import '../../util/change_notifier_manage.dart';
import '../../widgets/my_card.dart';
import '../iview/add_note_iview.dart';
import '../order_router.dart';
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
    required this.item,
    required this.products,

  });
  final int orderId;
  final List<AdminData> admins;
  final CollectionOrderData item;
  final List<ProductData> products;
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
  CollectionLogEntity? _data = null ;
  List<CollectionLogOtherContactInfo> _contactList = <CollectionLogOtherContactInfo>[];
  List<CollectionLogOtherSmsHistory> _smsHistory = <CollectionLogOtherSmsHistory>[];
  CollectionLogOtherRepayInfo? _repayInfo ;
  final List<IconData> _iconList = [Icons.input,Icons.sync, Icons.more_time, Icons.do_not_touch, Icons.phone_disabled, Icons.hourglass_disabled, Icons.payment, Icons.check_circle, Icons.sms_outlined];
  final List<Color> _colorList = [Colors.brown,Colors.grey, Colors.blue, Colors.purpleAccent, Colors.red, Colors.orange, Colors.green, const Color(0xFF1B5E20),Colors.blueGrey,];
  late AddNotePresenter _addNotePresenter;

  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      10000,
      duration: Duration(seconds: 6),
      curve: Curves.easeOut,
    );
  }
  @override
  void initState() {
    super.initState();
    // 在初始化时自动滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      typeController.text = '1';
    });
  }

  Future<void> _onRefresh() async {
    _data = await _addNotePresenter.index(1, widget.orderId, true);
    _list = _data!.data!;
    _contactList = _data!.other!.contactInfo!;
    _smsHistory = _data!.other!.smsHistory!;
    _repayInfo = _data!.other!.repayInfo!;
    setState(() {
    });
    _scrollToBottom();
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
    _scrollToBottom();
  }

  @override
  bool get wantKeepAlive => true;

  Widget commentChild(List<CollectionLogData> data) {
    final Map<String, List<CollectionLogData>> groupedData = {};
    final Map<String, int> groupedOverdueDayData = {};
    for (final item in data) {
      final dateKey = DateFormat('MMM d, yyyy', 'en_US').format(DateTime.parse(item.createdAt!));
      if (!groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = [];
      }
      if(groupedData[dateKey]!.isEmpty){
        groupedOverdueDayData[dateKey] = item.mOverdueDays!;
      }
      groupedData[dateKey]!.add(item);
    }
    final List<_DeliveryProcess> deliveryProcesses = [];
    groupedData.forEach((date, items) {
      final messages = items.map((item) {
        final time = DateFormat("hh:mm a").format(DateTime.parse(item.createdAt!));
        return _DeliveryMessage(time, item.jContent!, item.gType!, _iconList[item.gType!], _colorList[item.gType!], _colorList[item.gType!], item.eCollectionAdminId!, item.kPromiseTime!);
      }).toList();
      deliveryProcesses.add(_DeliveryProcess(date, groupedOverdueDayData[date]!, Icons.import_contacts, Colors.black54, Colors.black87, messages: messages));
    });
    return Container(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _DeliveryProcesses(processes: deliveryProcesses, admins: widget.admins,),
            Divider(height: 1.0),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Map<String, Object> logData;
    return SafeArea(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                child: OrderItem(
                  key: Key('order_item_'),
                  index: 1, tabIndex: 1,inList: false,admins: widget.admins,
                  products: widget.products, item: widget.item,
                  smsHistory: _smsHistory, repayInfo: _repayInfo, contactList: _contactList,
                  onSendSms: (smsTemplateId, smsContent, {String? phone, int? contactId}) {
                    logData = {
                      'g_type': 8,
                      'j_content': smsContent.trim(),
                      'created_at': DateTime.now(),
                      'e_collection_admin_id': 0,
                      'k_promise_time': '',
                      'n_sms_template_id': smsTemplateId,
                      'h_phone': phone ?? '',
                      'o_contact_id': contactId ?? 0,
                    };
                    _addNotePresenter.store(logData,  true);
                  },
                )
            ),
            // Text("My Collection Log"),
            Gaps.vGap4,
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(left: 4, right: 4),
                child: MyCard(
                  shadowColor: Colors.grey.withOpacity(0.2),
                  child: MyCommentBox(
                    child: commentChild(_list),
                    labelText: 'Write a comment...',
                    errorText: 'Comment cannot be blank',
                    withBorder: false,
                    sendButtonMethod: () async {
                      if (formKey.currentState!.validate()) {
                        var value = {
                          'g_type': typeController.text,
                          'j_content': commentController.text.trim(),
                          'created_at': DateTime.now(),
                          'e_collection_admin_id': 0,
                          'k_promise_time': dateController.text,
                        };
                        setState(() {
                          _list.add(CollectionLogData.fromJson(value));
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

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes, required this.admins})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  final List<AdminData> admins;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            indicatorPosition: 0,
            color: Colors.white,
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 0.01,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 1.6,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        processes[index].date,
                        style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        processes[index].overdueDays == 0 ? '' : ' (${processes[index].overdueDays} days)',
                        style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  _InnerTimeline(messages: processes[index].messages, admins: admins,),
                ],
              );
            },
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) {
                return DotIndicator(
                  color: processes[index].color,
                  child: Icon(
                    processes[index].icon,
                    color: processes[index].iconColor,
                    size: 12.0,
                  ),
                );
              } else {
                return OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: processes[index].isCompleted ? Color(0xff66c97f) : null,
            ),
          ),
        ),
      ),
    );
  }
}




class _DeliveryProcess {
  const _DeliveryProcess(
      this.date,this.overdueDays, this.icon, this.color, this.iconColor, {
        this.messages = const [],
      });

  const _DeliveryProcess.complete()
      : this.date = 'Done',
        this.overdueDays = 0,
        this.messages = const [],
        this.icon = Icons.payment,
        this.color = Colors.green,
        this.iconColor = Colors.white;

  final String date;
  final int overdueDays;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => date == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message, this.status, this.icon, this.color, this.iconColor, this.adminId, this.promiseTime);

  final String createdAt; // final DateTime createdAt;
  final String message;
  final int status;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final int adminId;
  final String promiseTime;

  @override
  String toString() {
    return '$createdAt $message';
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
    required this.admins,
  });

  final List<_DeliveryMessage> messages;
  final List<AdminData> admins;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      // return index == 0 || index == messages.length + 1;
      return false;
    }
    final TextStyle? textTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp14);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          // indicatorPosition:1,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
            thickness: 1.0,
            space: 10,
          ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
            size: 10.0,
            position: 0.5,
          ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
          !isEdgeIndex(index) ? DotIndicator(
            position: 0.5,
            // border: Border(top:BorderSide(width: 1,color: Colors.black)),
            color: Colors.white,
            size: 26,
            child: Text(messages[index].createdAt, style: TextStyle(fontSize: 10)),
          ) : null,
          startConnectorBuilder: (_, index) => Connector.dashedLine(color: messages[index ].iconColor,),
          endConnectorBuilder: (_, index) => Connector.dashedLine(color: messages[index ].iconColor,),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: messages[index ].iconColor.withOpacity(0.14),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text( admins.firstWhere((admin) => admin.id == messages[index ].adminId).aName ?? 'You' , style: TextStyle(fontSize: 12)),
                      Text(' :', style: TextStyle(fontSize: 12)),

                      const Expanded(child: Gaps.empty),

                      if(messages[index ].status == 2 )  Text('Promise to Pay by ${DateFormat("MMM dd 'at' HH:mm").format(DateTime.parse(messages[index ].promiseTime))}', style: TextStyle(fontSize: 10, color: messages[index ].iconColor)) else Icon(
            messages[index ].icon,
            color: messages[index ].iconColor,
            size: 16.0,
            ),
                      // Icon(messages[index ].icon, color: messages[index ].iconColor, size: 12,),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        // TextSpan(text: messages[index].createdAt),
                        // TextSpan(text: " "),
                        TextSpan(text: messages[index].message,style: TextStyle(fontSize: 12)),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemExtentBuilder: (_, index) {
            if(messages[index].toString().length < 45){
              return 50;
            }else if(messages[index].toString().length < 90){
              return 70;
            }else if(messages[index].toString().length < 135){
              return 100;
            }else if(messages[index].toString().length < 180){
              return 105;
            }else{
              return 50;
            }
          },
          nodeItemOverlapBuilder: (_, index) =>
          isEdgeIndex(index) ? true : null,
          itemCount: messages.length  ,
          // itemExtent:60,
        ),
      ),
    );
  }
}