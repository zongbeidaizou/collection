import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/widgets/pay_type_dialog.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/admin_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../shop/widgets/price_input_dialog.dart';
import '../order_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';

import 'dart:ui';

import 'add_note.dart';


const List<String> orderLeftButtonText = ['拒单', '拒单', '订单跟踪', '订单跟踪', '订单跟踪'];
const List<String> orderRightButtonText = ['接单', '开始配送', '完成', '', ''];

class OrderItem extends StatelessWidget {

  const OrderItem({
    super.key,
    required this.tabIndex,
    required this.index,
    required this.item,
    required this.products,
    required this.admins,
    this.inList = true,
  });

  final int tabIndex;
  final int index;
  final bool inList;
  final CollectionOrderData item;
  final List<ProductData> products;
  final List<AdminData> admins;

  
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        shadowColor:inList ? (isDark ? Colors.white: Colors.blueGrey.withOpacity(0.6)) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildContent(context),
        ),
      )
    );
  }

  Widget _buildContent(BuildContext context) {
    final TextStyle? textTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = context.isDark;
    Future<int?> _showModalBottomSheet() {
      return showModalBottomSheet<int>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: 700,
            color: Colors.grey,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: AddNote(orderId: item.id!, admins: admins),     //AddNote should be your Widget that will be displayed inside the bottomSheet
            ),
          );
          return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          );
        },
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[

            Expanded(
              child: Text(products.firstWhere((product) => product.id == item.AJProductId).bName ?? '',                 style: const TextStyle(
                fontSize: Dimens.font_sp14,
                fontWeight: FontWeight.w500,
              ),),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                'Promise to repay',
                style: TextStyle(
                  fontSize: Dimens.font_sp12,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        Gaps.vGap4,
        Gaps.line,
        Gaps.vGap4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
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
                      children: <TextSpan>[
                        // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                        TextSpan(text: item.tBorrowSn),
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
            ),

            Gaps.hGap4,
            Expanded(
              flex: 2,
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
                    children: <TextSpan>[
                      // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                      const TextSpan(text: 'SAMUEL TAMALE'),
                    ],
                  ),
                ),
              ],),
            ),
            Gaps.hGap4,
            Expanded(
              flex: 2,
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
                    children: <TextSpan>[
                      // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                      const TextSpan(text: '159***312'),
                    ],
                  ),
                ),
              ],),
            ),
          ],),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(
            flex: 2,
            child: InkWell(
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
                    children: <TextSpan>[
                      // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                      const TextSpan(text: '\$3000'),
                    ],
                  ),
                ),
              Gaps.hGap2,
              ],),
              onTap: () {
                FlutterClipboard.copy('hello flutter friends').then(( value ) => Toast.show('BV24022939902E copied'));
              },
            ),
          ),

          Gaps.hGap4,
          Expanded(
            flex: 2,
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
                  children: <TextSpan>[
                    // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                    const TextSpan(text: '2024/03/01'),
                  ],
                ),
              ),
            ],),
          ),
          Gaps.hGap4,
          Expanded(
            flex:2,
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
                  children: <TextSpan>[
                    // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                    const TextSpan(text: 'overdue 12 days'),
                  ],
                ),
              ),
            ],),
          ),
        ],),
        Gaps.vGap8,
        // Gaps.line,
        Row(
          children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
              height: 52,
              decoration: BoxDecoration(
                color: Color(0xFFFFA113).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(width: 52, height: 52, "assets/images/clock-svgrepo-com.svg",),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3 days remaining"),
                      Text("last note at yestorday 09:36", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 8)),
                    ],
                  ),
                ],
              ),
            ),
          ),
            Gaps.hGap4,
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
              height: 52,
              decoration: BoxDecoration(
                color: Color(0xFFFFA113).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(width: 52, height: 52, "assets/images/money-earn-svgrepo-com.svg",),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("300 reward"),
                      Text("current lv. 1 with 4% of amount", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 8)),
                    ],
                  ),
                  // Text(" (level 1 with 4% amount)", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 6)),

                ],
              ),
            ),
          ),
        ],),

        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        if (inList) Row(
          children: <Widget>[
            const Expanded(
              child: Gaps.empty,
            ),
            Gaps.hGap4,

            OrderItemButton(
              key: Key('order_button_3_Add'),
              text: "Action",
              textColor: isDark ? Colours.dark_text : Colours.text,
              bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
              onTap: () {
                if (tabIndex == 2) {
                  _showPayTypeDialog(context);
                }
              },
            ),
            Gaps.hGap4,
            OrderItemButton(
              key: Key('order_button_3_$index'),
              text: "Detail",
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              onTap: () {
                _showModalBottomSheet();
              },
            )
          ],
        ) else Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
/*    IconButton(
    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
    icon: FaIcon(FontAwesomeIcons.gamepad),
    onPressed: () { print("Pressed"); }
    ),*/
            OrderItemButton(
              key: Key('whatsapp'),
              text: "Whatsapp",
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              icon: FaIcon(FontAwesomeIcons.whatsapp, size: 20, color: Colors.white),
              onTap: () async {
                var now = DateTime.now();
                int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
                int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;

              },
            ),
            Gaps.hGap4,
            OrderItemButton(
              key: Key('order_button_2_$index'),
              text: "Call",
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              icon: Icon(Icons.call, size: 20, color: Colors.white),
              onTap: () async {
                var now = DateTime.now();
                int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
                int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;

              },
            ),
            Gaps.hGap4,
            OrderItemButton(
              key: Key('order_button_2_send'),
              text: "Sms",
              icon: Icon(Icons.message, size: 20, color: Colors.white),
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              onTap: () {
                _showPayTypeDialog(context);
                if (tabIndex >= 2) {
                  NavigatorUtils.push(context, OrderRouter.orderTrackPage);
                }
              },
            ),


          ],
        )
      ],
    );
  }

  void _showCallPhoneDialog(BuildContext context, String phone) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Text('是否拨打：$phone ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => NavigatorUtils.goBack(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Utils.launchTelURL(phone);
                NavigatorUtils.goBack(context);
              },
              style: ButtonStyle(
                // 按下高亮颜色
                overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.error.withOpacity(0.2)),
              ),
              child: Text('拨打', style: TextStyle(color: Theme.of(context).colorScheme.error),),
            ),
          ],
        );
      },
    );
  }

  void _showPayTypeDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: SmsDialog(
            onPressed: (index, type) {
              Toast.show('收款类型：$type');
            },
          ),
        );
      },
    );
  }



}


class OrderItemButton extends StatelessWidget {
  
  const OrderItemButton({
    super.key,
    this.bgColor,
    this.textColor,
    required this.text,
    this.onTap,
    this.icon
  });
  
  final Color? bgColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String text;
  final Widget? icon;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        constraints: BoxConstraints(
          minWidth: icon != null ? 120 : 64,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: icon != null ? Row(
          children: [
          Text(text, style: TextStyle(fontSize: Dimens.font_sp14, color: textColor)),
            Gaps.hGap8,
            icon!,
          ],
        ) : Text(text, style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),),
      ),
    );
  }
}
