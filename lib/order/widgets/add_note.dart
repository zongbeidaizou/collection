import 'dart:convert';

import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/util/image_utils.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:timelines/timelines.dart';
import 'package:clipboard/clipboard.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../mvp/base_page.dart';
import '../../providers/order_list_provider.dart';
import '../../res/colors.dart';
import '../../res/dimens.dart';
import '../../res/gaps.dart';
import '../../routers/fluro_navigator.dart';
import '../../util/change_notifier_manage.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_card.dart';
import '../iview/add_note_iview.dart';
import '../order_router.dart';
import '../presenter/add_note_presenter.dart';
import 'MyCommentBox.dart';
import 'order_item.dart';
import 'repayment_bill_dialog.dart';

void main() {}

class AddNote extends StatefulWidget {
  const AddNote({
    super.key,
    required this.orderId,
    // required this.admins,
    required this.item,
    // required this.products,
  });
  final int orderId;
  // final List<AdminData> admins;
  final String item;
  // final List<ProductData> products;
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote>
    with
        AutomaticKeepAliveClientMixin<AddNote>,
        BasePageMixin<AddNote, AddNotePresenter>
    implements AddNoteIMvpView {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  List<CollectionLogData> _list = <CollectionLogData>[];
  CollectionLogEntity? _data = null;
  List<CollectionLogOtherContactInfo2Data> _contactList =
      <CollectionLogOtherContactInfo2Data>[];
  List<CollectionLogOtherSmsHistory> _smsHistory =
      <CollectionLogOtherSmsHistory>[];
  CollectionLogOtherRepayInfo? _repayInfo;
  String? _avatar;
  CollectionLogOtherTrack? _track;
  CollectionLogOtherPeriod? _period;
  final List<IconData> _iconList = [
    Icons.input,
    Icons.sync,
    Icons.more_time,
    Icons.hourglass_disabled,
    Icons.phone_disabled,
    Icons.transfer_within_a_station,
    Icons.payment,
    Icons.check_circle,
    Icons.sms_outlined
  ];
  final List<Color> _colorList = [
    Colors.brown,
    Colors.grey,
    Colors.green,
    Colors.orange,
    Colors.purpleAccent,
    Colors.red,
    Colors.green,
    const Color(0xFF1B5E20),
    Colors.blueGrey,
  ];
  late AddNotePresenter _addNotePresenter;
  late CollectionOrderData item;
  List<ProductData> _product = <ProductData>[];
  List<AdminData> _admins = <AdminData>[];
  List<CollectionLogOtherContactInfo2Data> _contact2List = [];
  List<CollectionLogOtherContactInfo2Data> _allContactList = [];
  int _showContactDays = 0;

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
    item = CollectionOrderData.fromJson(
        jsonDecode(widget.item) as Map<String, dynamic>);
    // 在初始化时自动滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      typeController.text = '1';
      await Permission.manageExternalStorage.request();
      // await Permission.audio.request();
      await Permission.storage.request();
    });
  }

  @override
  void setProduct(List<ProductData> product) {
    setState(() {
      _product = product;
    });
  }

  @override
  void setAdmin(List<AdminData> admin) {
    setState(() {
      _admins = admin;
    });
  }

  Future<void> _onRefresh() async {
    _data = await _addNotePresenter.index(1, widget.orderId, true);
    _list = _data!.data!;
    _contactList = SpUtil.getObjectList("contactList:${widget.orderId}")
            ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(
                e as Map<String, dynamic>))
            .toList() ??
        [];
    _smsHistory = _data!.other!.smsHistory!;
    _repayInfo = _data!.other!.repayInfo;
    _track = _data!.other!.track;
    _period = _data!.other!.period;
    _avatar = _data!.other!.avatar;
    _showContactDays = _data!.other!.showContactDays!;

    _contact2List = SpUtil.getObjectList("contact2List:${widget.orderId}")
            ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(
                e as Map<String, dynamic>))
            .toList() ??
        [];
    _allContactList = SpUtil.getObjectList("allContactList:${widget.orderId}")
            ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(
                e as Map<String, dynamic>))
            .toList() ??
        [];
    print("contact2List:${widget.orderId}");
    print(_contact2List.length);
    print(_allContactList.length);
    setState(() {});
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
      final dateKey = DateFormat('MMM d, yyyy', 'en_US')
          .format(DateTime.parse(item.createdAt!));
      if (!groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = [];
      }
      if (groupedData[dateKey]!.isEmpty) {
        groupedOverdueDayData[dateKey] = item.mOverdueDays!;
      }
      groupedData[dateKey]!.add(item);
    }
    final List<_DeliveryProcess> deliveryProcesses = [];
    groupedData.forEach((date, items) {
      final messages = items
          .map((item) {
            final time = DateFormat('hh:mm a').format(
                DateTime.parse(item.createdAt!)
                    .toUtc()
                    .add(const Duration(hours: 1))); // 转换为尼日利亚时区(UTC+1)
            return _DeliveryMessage(
                time,
                item.jContent!,
                item.gType!,
                _iconList[item.gType!],
                _colorList[item.gType!],
                _colorList[item.gType!],
                item.eCollectionAdminId!,
                item.kPromiseTime ?? '');
          })
          .toList()
          .reversed
          .toList();
      deliveryProcesses.add(_DeliveryProcess(date, groupedOverdueDayData[date]!,
          Icons.import_contacts, Colors.black54, Colors.black87,
          messages: messages));
    });
    return Container(
      child: Stack(
        children: [
          // 背景文字
          Positioned.fill(
            child: Center(
              child: Text(
                item.aZPackage ?? '',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colours.app_main.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // 主要内容
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _DeliveryProcesses(
                  processes: deliveryProcesses.reversed.toList(),
                  admins: _admins,
                ),
                Divider(height: 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Map<String, Object> logData;
    return Scaffold(
        //todo 搜索
        // appBar: MySearchBar(
        //   hintText: 'Search by Phone, Order, Code, Log',
        //   onPressed: (text) =>  _updateSearchKeyword(text),
        //   controller: _controller,
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colours.app_main,
          flexibleSpace: Container(
            height: 115.0,
            color: _repayInfo?.appName == 'kaka'
                ? Colors.blue
                : _repayInfo?.appName == 'leading'
                    ? Colors.green
                    : Colors.orange,
          ),
          title: GestureDetector(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return RepaymentBillDialog(
                      avatar: _avatar,
                      repayInfo: _repayInfo,
                      period: _period,
                      track: _track,
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // backgroundImage: NetworkImage(_avatar?? '',),
                    // backgroundImage:
                    //     ImageUtils.getAssetImage('order/icon_avatar'),
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _avatar ?? '',
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/order/icon_avatar.png', // 加载中的占位图
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            'assets/images/order/order_delete.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(item.vName ?? '',
                      style: TextStyle(
                          color: ThemeUtils.getIconColor(context),
                          fontSize: 18)),
                ],
              )),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Column(
              children: [
                OrderItem(
                  key: Key('order_item_'),
                  index: 1,
                  tabIndex: 1,
                  inList: false,
                  admins: _admins,
                  showContactDays: _showContactDays,
                  products: _product,
                  item: item,
                  smsHistory: _smsHistory,
                  repayInfo: _repayInfo,
                  couponList: _data?.other?.couponList ?? const [],
                  contactList: _contact2List,
                  allContactList: _allContactList,
                  track: _track,
                  period: _period,
                  moreAction: (i) {
                    _addNotePresenter.moreAction(i, item.id!);
                  },
                  onSendSms: (smsTemplateId, smsContent,
                      {String? phone, int? contactId}) {
                    logData = {
                      'g_type': 8,
                      'j_content': smsContent.trim(),
                      'created_at': DateTime.now(),
                      'e_collection_admin_id': 0,
                      'k_promise_time': '',
                      'n_sms_template_id': smsTemplateId,
                      'h_phone': phone ?? '',
                      'o_contact_id': contactId ?? 0,
                      'p_collection_order_id': widget.orderId,
                    };
                    _addNotePresenter.store(logData, null, true, null);
                  },
                  // track: ,
                ),
                // Text('My Collection Log'),
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
                        sendButtonMethod: (List<XFile>? pickedFiles) async {
                          if (formKey.currentState!.validate()) {
                            var value = {
                              'g_type': typeController.text,
                              'j_content': commentController.text.trim(),
                              'created_at': DateTime.now(),
                              'e_collection_admin_id': 0,
                              'k_promise_time': dateController.text,
                            };
                            showToast(
                                'Cx.${item.uPhone!} ${commentController.text}');
                            setState(() {
                              // 修改为在列表最前面追加元素
                              _list.insert(
                                  0, CollectionLogData.fromJson(value));
                            });
                            //上传图片
                            print(pickedFiles);
                            await _addNotePresenter.store({
                              'p_collection_order_id': widget.orderId,
                              ...value
                            }, pickedFiles, true, item);
                            commentController.clear();
                            // dateController.clear();
                            // typeController.clear();
                            FocusScope.of(context).unfocus();
                          } else {
                            print('Not validated');
                          }
                          NavigatorUtils.goBack(context);
                        },
                        formKey: formKey,
                        commentController: commentController,
                        dateController: dateController,
                        typeController: typeController,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        sendWidget: Icon(Icons.send_sharp,
                            size: 28, color: Colours.app_main),
                      ),
                    ),
                  ),
                ),
                Gaps.line,
              ],
            ),
          ),
        ));
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses(
      {Key? key, required this.processes, required this.admins})
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
                        processes[index].overdueDays == 0
                            ? ''
                            : ' (Day ${processes[index].overdueDays} past due.)',
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  _InnerTimeline(
                    messages: processes[index].messages,
                    admins: admins,
                  ),
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
    this.date,
    this.overdueDays,
    this.icon,
    this.color,
    this.iconColor, {
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
  const _DeliveryMessage(this.createdAt, this.message, this.status, this.icon,
      this.color, this.iconColor, this.adminId, this.promiseTime);

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
    final bool isDark = context.isDark;
    final TextStyle? textTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: Dimens.font_sp14);

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
          indicatorBuilder: (_, index) => !isEdgeIndex(index)
              ? DotIndicator(
                  position: 0.5,
                  // border: Border(top:BorderSide(width: 1,color: Colors.black)),
                  color: Colors.white,
                  size: 36,
                  child: Container(
                    width: 36,
                    height: 36,
                    padding: EdgeInsets.only(left: 6, right: 0, top: 7, bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(messages[index].createdAt,
                        style: TextStyle(fontSize: 10)),
                  ),
                )
              : null,
          startConnectorBuilder: (_, index) => Connector.dashedLine(
            color: messages[index].iconColor,
          ),
          endConnectorBuilder: (_, index) => Connector.dashedLine(
            color: messages[index].iconColor,
          ),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: messages[index].iconColor.withOpacity(0.14),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          admins
                                  .where((admin) =>
                                      admin.id == messages[index].adminId)
                                  .firstOrNull
                                  ?.aName ??
                              'You',
                          style: TextStyle(fontSize: 12)),
                      Text(' :', style: TextStyle(fontSize: 12)),

                      const Expanded(child: Gaps.empty),

                      if (messages[index].status == 2)
                        Row(
                          children: [
                            Text(
                                'Promise to Pay by ${DateFormat("MMM dd 'at' HH:mm").format(DateTime.parse(messages[index].promiseTime))}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: messages[index].iconColor)),
                            Gaps.hGap10,
                            Icon(
                              messages[index].icon,
                              color: messages[index].iconColor,
                              size: 16.0,
                            ),
                          ],
                        )
                      else
                        Icon(
                          messages[index].icon,
                          color: messages[index].iconColor,
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
                        TextSpan(
                            text: messages[index].message,
                            style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemExtentBuilder: (_, index) {
            if (messages[index].toString().length < 45) {
              return 50;
            } else if (messages[index].toString().length < 90) {
              return 70;
            } else if (messages[index].toString().length < 135) {
              return 100;
            } else if (messages[index].toString().length < 180) {
              return 105;
            } else if (messages[index].toString().length < 280) {
              return 125;
            } else if (messages[index].toString().length < 580) {
              return 155;
            } else {
              return 50;
            }
          },
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: messages.length,
          // itemExtent:60,
        ),
      ),
    );
  }
}
