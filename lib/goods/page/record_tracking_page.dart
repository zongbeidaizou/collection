import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:bounty_hunter/util/toast_utils.dart';

import '../../order/order_router.dart';
import '../../order/widgets/order_item.dart';
import '../../res/colors.dart';
import '../../res/dimens.dart';
import '../../res/gaps.dart';

import 'package:timelines/timelines.dart';

import '../../routers/fluro_navigator.dart';

class RecordTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final data = _data(index + 1);
          return Center(
            child: Container(
              child: Card(
                shadowColor:isDark ? Colors.white: Colors.blueGrey.withOpacity(0.6),
                elevation: 5,
                margin: EdgeInsets.all(6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _OrderTitle(
                        orderInfo: data,
                      ),
                    ),
                    Divider(height: 1.0),
                    _DeliveryProcesses(processes: data.deliveryProcesses),
                    Divider(height: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: _OnTimeBar(driver: data.driverInfo),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  final _OrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = context.isDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
             Expanded(
              child: Text('15921158542（SAMUEL TAMALE）'),
            ),

          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 4.0),
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                    color: Colours.app_main.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: textTextStyle,
                    children: const <TextSpan>[
                      // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                       TextSpan(text: 'BV24022939902E'),
                    ],
                  ),
                ),
                Gaps.hGap2,
                Icon(Icons.content_copy, size: 12,color: Colours.app_main.withOpacity(0.6),),
              ],),
              onTap: () {
                FlutterClipboard.copy('hello flutter friends').then(( value ) => Toast.show('BV24022939902E copied'));
              },
            ),

            Gaps.hGap4,
            Row(children: [
              Container(
                margin: const EdgeInsets.only(right: 4.0),
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  color: Colours.app_main.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children:const <TextSpan>[
                    // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                     TextSpan(text: '\$3000'),
                  ],
                ),
              ),
            ],),
            Gaps.hGap4,
            Row(children: [
              Container(
                margin: const EdgeInsets.only(right: 4.0),
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  color: Colours.app_main.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: const <TextSpan>[
                    // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                    TextSpan(text: '2024/03/01'),
                  ],
                ),
              ),
            ],),
          ],),
        Gaps.vGap8,
        // Gaps.line,

      ],
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<_DeliveryMessage> messages;

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
            size: 16,
            child: Icon(
              messages[index ].icon,
              color: messages[index ].iconColor,
              size: 16.0,
            ),
          ) : null,
          startConnectorBuilder: (_, index) => Connector.dashedLine(color: messages[index ].iconColor,),
          endConnectorBuilder: (_, index) => Connector.dashedLine(color: messages[index ].iconColor,),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: messages[index].createdAt),
                    TextSpan(text: " "),
                    TextSpan(text: messages[index].message,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp12)),

                  ],
                ),
              ),
            );
          },
          itemExtentBuilder: (_, index) {
            print(messages[index].toString());
            print(messages[index].toString().length);
            if(messages[index].toString().length < 45){
              return 30;
            }else if(messages[index].toString().length < 90){
              return 50;
            }else if(messages[index].toString().length < 135){
              return 70;
            }else if(messages[index].toString().length < 180){
              return 95;
            }else{
              return 30;
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

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
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
            color: Colors.red,
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      processes[index].date,
                      style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    _InnerTimeline(messages: processes[index].messages),
                  ],
                ),
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

class _OnTimeBar extends StatelessWidget {
  const _OnTimeBar({Key? key, required this.driver}) : super(key: key);

  final _DriverInfo driver;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return Row(
      children: <Widget>[
        const Expanded(
          child: Gaps.empty,
        ),
        OrderItemButton(
          key: Key('order_button_2_Call'),
          text: "Call",
          textColor: isDark ? Colours.dark_text : Colours.text,
          bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
          onTap: () {
              NavigatorUtils.push(context, OrderRouter.orderTrackPage);
          },
        ),
        Gaps.hGap4,
        OrderItemButton(
          key: Key('order_button_2_send'),
          text: "Sms",
          textColor: isDark ? Colours.dark_text : Colours.text,
          bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
          onTap: () {
              NavigatorUtils.push(context, OrderRouter.orderTrackPage);
          },
        ),
        Gaps.hGap4,
        OrderItemButton(
          key: Key('order_button_3_Add'),
          text: "Note",
          textColor: isDark ? Colours.dark_text : Colours.text,
          bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
          onTap: () {

          },
        ),
        Gaps.hGap4,
        OrderItemButton(
          key: Key('order_button_3_Detail'),
          text: "Detail",
          textColor: isDark ? Colours.dark_button_text : Colors.white,
          bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
          onTap: () {

          },
        )
      ],
    );
  }
}

_OrderInfo _data(int id) => _OrderInfo(
  id: id,
  date: DateTime.now(),
  driverInfo: _DriverInfo(
    name: 'Philipe2',
    thumbnailUrl:
    'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
  ),
  deliveryProcesses: [
    const _DeliveryProcess(
      '2024/02/20',
      Icons.abc,
      Colors.red,

      Colors.red,
      messages: [
        _DeliveryMessage('8:30am', 'could not call 电话未接通could not call 电话未接通could not call 电话未接通could not call 电话未接通could not call 电话未接通could not call 电话未接通', 1, Icons.phone_disabled, Colors.black, Colors.blueAccent),
        _DeliveryMessage('11:30am', 'Under negotiation 协商中Under negotiation 协商中Under negotiation 协商中Under negotiation 协商中Under negotiation 协商中', 1, Icons.sync, Colors.black, Colors.grey),
        _DeliveryMessage('2:12pm', 'Package received by Package received by', 1, Icons.more_time, Colors.green, Colors.green),
        _DeliveryMessage('3:41pm', 'Package received by driver承诺未还', 1, Icons.hourglass_disabled, Colors.black, Colors.redAccent),
        _DeliveryMessage('7:08pm', 'Package received by driver拒不还款', 1, Icons.do_not_touch, Colors.black, Colors.purpleAccent),
      ],
    ),
    const _DeliveryProcess(
      '2024/02/22',
      Icons.abc,
      Colors.white,
      Colors.green,
      messages: [
        _DeliveryMessage('8:30am', 'Package received by driver', 1, Icons.alarm_off, Colors.black, Colors.green),
        _DeliveryMessage('11:30am', 'Package received by driver', 1, Icons.error_outline, Colors.black, Colors.green),
        _DeliveryMessage('2:12pm', 'Package received by driver', 1, Icons.phonelink_erase, Colors.black, Colors.green),
      ],
    ),
    _DeliveryProcess.complete(),
  ],
);

class _OrderInfo {
  const _OrderInfo({
    required this.id,
    required this.date,
    required this.driverInfo,
    required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
  final _DriverInfo driverInfo;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}

class _DeliveryProcess {
  const _DeliveryProcess(
      this.date, this.icon, this.color, this.iconColor, {
        this.messages = const [],
      });

  const _DeliveryProcess.complete()
      : this.date = 'Done',
        this.messages = const [],
        this.icon = Icons.payment,
        this.color = Colors.green,
        this.iconColor = Colors.white;

  final String date;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => date == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message, this.status, this.icon, this.color, this.iconColor);

  final String createdAt; // final DateTime createdAt;
  final String message;
  final int status;
  final IconData icon;
  final Color color;
  final Color iconColor;

  @override
  String toString() {
    return '$createdAt $message';
  }
}
