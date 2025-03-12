
import 'dart:convert';

import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/device_utils.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_scroll_view.dart';
import 'package:intl/intl.dart';

import '../../models/collection_log_entity.dart';
import '../../util/input_formatter/number_text_input_formatter.dart';
import '../order_router.dart';


/// design/3订单/index.html#artboard10
class OrderInfoPage extends StatefulWidget {

  const OrderInfoPage({
    super.key,
    required this.orderId,
    required this.track,
    required this.period,
  });
  final int orderId;
  final String track;
  final String period;

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  late CollectionLogOtherTrack _track ;
  late CollectionLogOtherPeriod _period ;
  bool _immediatelyPay = false;
  bool _clickable = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(_verify);
    _track = CollectionLogOtherTrack.fromJson(jsonDecode(widget.track) as Map<String, dynamic >);
    _period = CollectionLogOtherPeriod.fromJson(jsonDecode(widget.period) as Map<String, dynamic >);

  }
  @override
  void dispose() {
    _controller.removeListener(_verify);
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
  void _verify() {
    final price = _controller.text;
    if (price.isEmpty || double.parse(price) < 1) {
      setState(() {
        _clickable = false;
      });
      return;
    }
    setState(() {
      _clickable = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Color red = Theme.of(context).colorScheme.error;
    final bool isDark = context.isDark;

    final Widget bottomMenu = Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            height: 44.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: MyButton(
                backgroundColor: isDark ? Colours.dark_material_bg : const Color(0xFFE1EAFA),
                textColor: isDark ? Colours.dark_text : Colours.app_main,
                text: '拒单',
                minHeight: 45,
                onPressed: () {},
              ),
            ),
            Gaps.hGap16,
            Expanded(
              child: MyButton(
                text: '接单',
                minHeight: 45,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );

    final List<Widget> children = [
      Gaps.vGap8,
      MyCard(
          shadowColor: Colors.grey.withOpacity(0.6),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
                    const Text(
            'Loan Info',
            style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    Gaps.line,
                    Gaps.vGap4,
                    _buildGoodsInfoItem('Apply Time', DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(_track.applyTime!))),
                    _buildGoodsInfoItem('Borrow Amount', Utils.formatPrice2(_track.borrowAmount!)),
                    _buildGoodsInfoItem('Loan Time', DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(_track.loanTime!))),
                    // _buildGoodsInfoItem('优惠券', Utils.formatPrice2('-2.50'), contentTextColor: red),
                    _buildGoodsInfoItem('Loan Amount', Utils.formatPrice2(_track.loanAmount!)),
                    _buildGoodsInfoItem('Loan Mobile Money Number', _track.loanBank!),
                  ],),
          )),
      Gaps.vGap8,
      MyCard(
          shadowColor: Colors.grey.withOpacity(0.6),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text(
                'Repay Info',
                style: TextStyles.textBold14,
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap4,
              _buildGoodsInfoItem('Expect Repay Time', DateFormat('MMM d, yyyy', 'en_US').format(DateTime.parse(_period.aPExpectRepayTime!))),
              _buildGoodsInfoItem('Should Repay Amount', Utils.formatPrice2(_period.fExpectRepayTotalAmount!)),
              _buildGoodsInfoItem('Overdue Days', _period.lOverdueDays.toString()),
              _buildGoodsInfoItem('Overdue Fee', Utils.formatPrice2(_period.kExpectOverdueAmount!)),
              _buildGoodsInfoItem('Paid', Utils.formatPrice2(_period.nPaidAmount!)),
              _buildGoodsInfoItem('Left Repay Amount', _period.aZLeftAmount.toString()),
            ],),
          )),
      Gaps.vGap8,
      MyCard(
          shadowColor: Colors.grey.withOpacity(0.6),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text(
                'deduction Info',
                style: TextStyles.textBold14,
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap4,
              _buildGoodsInfoItem('deduction Amount ', Utils.formatPrice2(_period.uDeductionTotalAmount!)),
              _buildGoodsInfoItem('deduction Times ', _period.tDeductionTimes.toString()),
              Gaps.vGap8,
              Row(
                children: <Widget>[
                  Container(
                    width: 25.0,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text("₦",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600),),
                  ),
                  Gaps.hGap8,
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [UsNumberTextInputFormatter()],
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        // contentPadding: EdgeInsets.only(bottom: 8.0),
                        hintStyle: TextStyle(
                          fontSize: Dimens.font_sp14,
                          fontWeight: FontWeight.normal,
                          color: Colours.text_gray_c,
                        ),
                        hintText: 'Not less than 1,000',
                        counterText: '',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.line,
              Gaps.vGap8,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('The maximum penalty reduction allowed is ${Utils.formatPrice2(_period.kExpectOverdueAmount!)}.', style: Theme.of(context).textTheme.titleSmall),
                  GestureDetector(
                      onTap: () {
                        _controller.text = '70';
                      },
                      child: SizedBox(
                        height: 20.0,
                        child: Text('Full reduction', style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: Theme.of(context).primaryColor,
                        )),
                      )
                  )
                ],
              ),
              Gaps.vGap8,
              TextField(
                controller: _controller2,
                maxLines: 2, // 设置最大行数，超过时会自动滚动
                decoration: InputDecoration(
                  labelText: 'Reduction Remarks (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              Gaps.vGap8,
              _buildWithdrawalType(0),
            ],),
          )),
    ];

    return Scaffold(
      appBar: MyAppBar(
        centerTitle: 'Order Info',
        // actionName: 'Reduction Record',
        onPressed: () {
          // NavigatorUtils.push(context, OrderRouter.orderTrackPage);
        },
      ),
      body: MyScrollView(
        key: const Key('order_info'),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        bottomButton: bottomMenu,
        children: children,
      )
    );
  }


  Widget _buildGoodsInfoItem(String title, String content, {Color? contentTextColor}) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: TextStyle(
                color: Colors.grey
            )),
            Text(content, style: TextStyle(
              color: contentTextColor ?? Theme.of(context).textTheme.bodyMedium?.color,
            ))
          ],
        ),
      ),
    );
  }
  Widget _buildWithdrawalType(int type) {
    return InkWell(
      onTap: () {
        setState(() {
          _immediatelyPay = !_immediatelyPay;
        });
      },
      child: SizedBox(
        width: double.infinity,
        height: 20.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0.0,
              child: LoadAssetImage(_immediatelyPay ? 'account/txxz' : 'account/txwxz', width: 16.0),
            ),
            Positioned(
              left: 24.0,
              right: 0.0,
              child: Text('The borrower has committed to repay after the reduction.',style: TextStyle(fontSize: 12,color: _immediatelyPay ? Colors.blueAccent : Colors.grey),),
            ),

          ],
        ),
      ),
    );
  }
}
