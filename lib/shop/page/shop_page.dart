import 'package:bounty_hunter/setting/widgets/exit_dialog.dart';
import 'package:bounty_hunter/shop/widgets/bar_marketing.dart';
import 'package:bounty_hunter/shop/widgets/pie2.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/account/account_router.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/setting/setting_router.dart';
import 'package:bounty_hunter/shop/iview/shop_iview.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';
import 'package:bounty_hunter/shop/presenter/shop_presenter.dart';
import 'package:bounty_hunter/shop/shop_router.dart';
import 'package:bounty_hunter/util/image_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/shop_entity.dart';
import '../../providers/user_provider.dart';
import '../widgets/bar.dart';
import '../widgets/bar2.dart';
import '../widgets/level_bar.dart';
import '../widgets/line.dart';
import '../widgets/pie.dart';
import '../widgets/resources/bar_chart_sample6.dart';

/// design/6店铺-账户/index.html#artboard0
class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
    this.isAccessibilityTest = false,
  });

  final bool isAccessibilityTest;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with
        BasePageMixin<ShopPage, ShopPagePresenter>,
        AutomaticKeepAliveClientMixin<ShopPage>,
        SingleTickerProviderStateMixin
    implements ShopIMvpView {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  ShopData _data = ShopData.fromJson({
    "web_url": "",
    "other": {
      "progress": {
        "points": [0, 1],
        "levelProgress": [],
        "amountProgress": [],
        "amountProgress2": [0, 0, 0, 0, 0],
        "currentLevel": 1,
        "nextAmount": 0,
        "nextLevel": 1,
        "currentKey": 0
      },
      "profile": {}
    },
    "show_month_data": false,
    "month_data": [],
    "show_week_case_data": false,
    "week_case_data": [],
    "show_week_bonus_data": false,
    "week_bonus_data": [],
    "show_month_case_data": false,
    "month_case_data": [],
    "show_month_bonus_data": false,
    "month_bonus_data": []
  });
  late ShopPagePresenter _shopPagePresenter;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.yellowAccent,
      end: Colors.blueAccent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setUser(UserEntity? user) {
    // provider.setUser(user);
  }

  @override
  bool get isAccessibilityTest => widget.isAccessibilityTest;
  void setData(ShopData data) {
    _data = data;
    setState(() {});
  }

  String formatNumberToK(int number) {
    if (number < 1000) {
      return number.toString(); // 小于1000直接返回原数字
    }

    double result = number / 1000;
    // 处理小数部分（避免四舍五入后显示.0时仍保留一位小数）
    if (result == result.truncate()) {
      return '${result.truncate()}K'; // 无小数的情况
    } else {
      return '${result.toStringAsFixed(1)}K'; // 保留一位小数
    }
  }

  Future<void> _onRefresh() async {
    _shopPagePresenter.show(true);
  }


  Widget _buildMonthHallOfFame(List<ShopDataMonthData> monthData, String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           MergeSemantics(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyles.textBold14,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 88,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: monthData.length,
              itemBuilder: (BuildContext context, int index) {
                Color iconColor = Colors.transparent;
                if (index == 0) {
                  iconColor = Colors.yellow.withOpacity(0.8);
                } else if (index == 1) {
                  iconColor = const Color(0xFFC0C0C0).withOpacity(0.8);
                } else if (index == 2) {
                  iconColor = const Color(0xFFB87333).withOpacity(0.8);
                }
                return index < 1
                    ? AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: <Widget>[
                                    /*                                Animate(
                              effects: [MoveEffect(), ScaleEffect()],
                              child: flashingBorder,
                            ),*/
                                    Animate(
                                      effects: const [
                                        FadeEffect(),
                                        ScaleEffect()
                                      ],
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.transparent
                                              /*color: _colorAnimation.value!,
                                    width: 4.0,*/
                                              ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 26.0,
                                          backgroundColor: Colors.transparent,
                                          // backgroundImage: ImageUtils.getAssetImage('avater/avater${index + 1}'),
                                          backgroundImage: ImageUtils
                                              .getImageProvider(
                                                  monthData[index].avatar,
                                                  holderImg: 'store/icon_zj'),
                                          // backgroundImage: LoadImage(item.icon, width: 72.0, height: 72.0),,
                                        ),
                                      )
                                          .animate(
                                              onPlay: (controller) =>
                                                  controller.repeat())
                                          .shimmer(
                                              duration: 2200.ms,
                                              color:
                                                  Colors.white.withOpacity(0.5))
                                          .animate() // this wraps the previous Animate in another Animate
                                          .fadeIn(
                                              duration: 2200.ms,
                                              curve: Curves.easeOutQuad)
                                          .slide(),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Icon(
                                        Icons.emoji_events_rounded,
                                        color: iconColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2.0),
                                  RichText(text: TextSpan(children: [
                                    TextSpan(text: formatNumberToK(monthData[index].value!)),
                                    if (monthData[index].addition! > 0)
                                      const TextSpan(text: '+', style: TextStyle(color:  Colors.green)),
                                    if (monthData[index].addition! > 0)
                                      TextSpan(text: formatNumberToK(monthData[index].addition!), style: const TextStyle(color:  Colors.green)),
                                  ]))
                              ],
                            ),
                          );
                        })
                    : Container(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 4.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 26.0,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: ImageUtils.getImageProvider(
                                        monthData[index].avatar,
                                        holderImg: 'store/icon_zj'),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Icon(
                                    Icons.emoji_events_rounded,
                                    color: iconColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2.0),
                            RichText(text: TextSpan(children: [
                              TextSpan(text: formatNumberToK(monthData[index].value!)),
                              if (monthData[index].addition! > 0)
                                TextSpan(text: '+', style: const TextStyle(color:  Colors.green)),
                              if (monthData[index].addition! > 0)
                                TextSpan(text: formatNumberToK(monthData[index].addition!), style: const TextStyle(color:  Colors.green)),
                            ])),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    final Widget line = Container(
      height: 0.6,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16.0),
      child: Gaps.line,
    );

    Widget flashingBorder = Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent.withOpacity(0.1),
      ),
      child: SizedBox.shrink(),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2600.ms, color: Colors.yellow[900])
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 2600.ms, curve: Curves.easeOutCirc);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colours.app_main,
        flexibleSpace: isDark
            ? Container(
                height: 115.0,
                color: Colors.black,
              )
            : Container(
                height: 115.0,
                color: Colors.indigoAccent,
              ),
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft, // 水平居左，垂直居中
            child: Consumer<UserProvider>(builder: (_, provider, __) {
              return Text(
                'Hi ${provider.userEntity.profile!.aName!}',
                style: const TextStyle(fontSize: 24,color: Colors.white),
              );
            }),
          ),
        ),
        leadingWidth: 300,
        actions: <Widget>[
          IconButton(
            tooltip: 'Day details',
            onPressed: () {
              _showAdminInfoDialog();
            },
            icon: Icon(
              Icons.calendar_month,
              color: iconColor,
              size: 20,
            ),
          ),
          IconButton(
            tooltip: 'Edit Note',
            onPressed: () {
              NavigatorUtils.push(context, SettingRouter.messageTemplatePage);
            },
            icon: Icon(
              Icons.edit_note,
              color: iconColor,
              size: 29,
            ),
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.squareWhatsapp,
                size: 23, color: iconColor),
            onPressed: () {
              NavigatorUtils.push(context, SettingRouter.waActivationPage);
            },
          ),
          IconButton(
            tooltip: 'Setting',
            onPressed: () {
              NavigatorUtils.push(context, SettingRouter.settingPage);
            },
            icon: Icon(Icons.settings, color: iconColor, size: 23),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey]
                : [Colors.indigoAccent, Colors.indigoAccent.withOpacity(0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // level your current hunt level is lv.1 with 4% of amount, collection more 5000 can touch lv2 with 6% of amount
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<UserProvider>(builder: (_, provider, __) {
                    return LevelBar(
                      data: provider.userEntity.progress!,
                      profile: provider.userEntity.profile!,
                    );
                  }),
                ),
                Gaps.vGap8,
                
                if (_data.showWeekBonusData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Bar2(
                        weekBonusData: _data.weekBonusData!,
                        weekCaseData: _data.weekCaseData!,
                        isShowingMainData: true),
                  )
                else
                  Gaps.empty,
                if (_data.showWeekCaseData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Bar2(
                        weekBonusData: _data.weekBonusData!,
                        weekCaseData: _data.weekCaseData!,
                        isShowingMainData: false),
                  )
                else
                  Gaps.empty,
                if (_data.showWeekRegisterData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: BarMarketing(
                        weekCaseData: _data.weekRegisterData!,
                        isRegister: true),
                  )
                else
                  Gaps.empty,
                if (_data.showWeekApplyData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: BarMarketing(
                        weekCaseData: _data.weekApplyData!, isRegister: false),
                  )
                else
                  Gaps.empty,
                  // 名人堂
                _buildMonthHallOfFame(_data.monthData!, 'Monthly Bonus Ranking'),
                Gaps.vGap4,
                _buildMonthHallOfFame(_data.monthRepayData!, 'Monthly Repayment Ranking'),
                Gaps.vGap4,
                _buildMonthHallOfFame(_data.monthRegBonusData!, 'Monthly Registration Bonus Ranking'),
                Gaps.vGap4,
                _buildMonthHallOfFame(_data.monthApplyBonusData!, 'Monthly Application Bonus Ranking'),
                Gaps.vGap4,
                if (_data.showMonthAdditionData!)
                  Column(
                    children: [
                      Gaps.vGap15,
                      Text(
                        'My Monthly Bonus',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70), // 外层边框
                          ),
                          child: Column(
                            children: [
                              // 表头 - 带背景色
                              Container(
                                color: Color(0xFF50E4FF), // 表头背景色
                                child: Row(
                                  children: [
                                    _buildHeaderCell('Performance Target',
                                        flex: 3),
                                    _buildHeaderCell('Bonus'),
                                    _buildHeaderCell('Progress Status',
                                        flex: 3),
                                  ],
                                ),
                              ),
                              // 表格内容
                              ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), // 禁止单独滚动
                                itemCount: _data.monthAdditionData!.length,
                                itemBuilder: (context, index) {
                                  ShopDataMonthAdditionData item =
                                      _data.monthAdditionData![index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white70), // 行底部边框
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        _buildDataCell(
                                            'Reach ${item.days} days at Grade ${item.level}',
                                            flex: 3),
                                        _buildDataCell(
                                            Utils.formatPrice2(item.bonus!)),
                                        if (item.completeDays! >= item.days!)
                                          _buildDataCell('Achieved! ✅', flex: 3)
                                        else
                                          _buildDataCell(
                                              '${item.completeDays}/${item.days}(${item.days! - item.completeDays!} days left for ${Utils.formatPrice2(item.bonus!)})',
                                              flex: 3),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Gaps.empty,
                if (_data.showMonthBonusData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      height: 300,
                      child: LineChartSample1(
                          monthBonusData: _data.monthBonusData!,
                          monthCaseData: _data.monthCaseData!,
                          isShowingMainData: true),
                    ),
                  )
                else
                  Gaps.empty,
                if (_data.showMonthCaseData!)
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      height: 300,
                      child: LineChartSample1(
                          monthBonusData: _data.monthBonusData!,
                          monthCaseData: _data.monthCaseData!,
                          isShowingMainData: false),
                    ),
                  )
                else
                  Gaps.empty,

                // 统计
                // LineChartSample1(monthBonusData: _data.monthBonusData!,monthCaseData: _data.monthCaseData!,),
                // BarChartSample6(),
                // Container(
                //   height: 208,
                //   padding: EdgeInsets.all(10),
                //   child: ListView.separated(
                //     separatorBuilder: (BuildContext context, int index) {
                //       // 定义分隔器
                //       return Container(
                //         width: 6.4, //
                //         // color: Colors.blue.withOpacity(0.1),// 分隔器高度，即每个元素之间的留白大小
                //       );
                //     },
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container(
                //         padding: EdgeInsets.all(2.0),
                //         decoration: BoxDecoration(
                // /*                          gradient: LinearGradient(
                //             // colors:  [Color(0xFF8C9EFF),Colors.limeAccent],
                //             colors:  [Colors.white,Colors.white],
                //             begin: Alignment.topLeft,
                //             end: Alignment.bottomRight,
                //           ),*/
                //           color: Colors.white.withOpacity(0.42),
                //           borderRadius: const BorderRadius.only(
                //               topLeft: Radius.circular(54.0),
                //               bottomLeft: Radius.circular(8.0),
                //               bottomRight: Radius.circular(8.0),
                //               topRight: Radius.circular(11.0)),
                //           boxShadow: <BoxShadow>[
                //             BoxShadow(color: Colors.transparent, offset: const Offset(0.1, 0.1), blurRadius: 100.0),
                //           ],
                //         ),
                //         width: MediaQuery.of(context).size.width * 0.71,
                //         child: Column(
                //           children: <Widget>[
                //             Row(
                //               children: [
                //                 GaugeTemperatureMonitorExample(),
                //                 Expanded(
                //                     child: Container(
                //                   child: Column(
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.start,
                //                         children: [
                //                           Text("2023 W30 Bonus"),
                //                         ],
                //                       ),
                //                       Gaps.vGap12,
                //                       Row(
                //                         children: [
                //                           Row(
                //                             children: [
                //                               Container(
                //                                 margin: const EdgeInsets.only(right: 4.0),
                //                                 width: 3.4,
                //                                 height: 20,
                //                                 decoration: BoxDecoration(
                //                                   color: Colors.blueAccent.withOpacity(0.2),
                //                                   borderRadius: BorderRadius.circular(4.0),
                //                                 ),
                //                               ),
                //                               Container(
                //                                 width: 26,
                //                                 child: Text(
                //                                   "lv.1:",
                //                                   style: TextStyle(fontSize: 14, color: Colors.grey),
                //                                 ),
                //                               ),
                //                               Text("400", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                             ],
                //                           ),
                //                           Gaps.hGap4,
                //                           Row(
                //                             children: [
                //                               Container(
                //                                 margin: const EdgeInsets.only(right: 4.0),
                //                                 width: 3.4,
                //                                 height: 20,
                //                                 decoration: BoxDecoration(
                //                                   color: Colors.blueAccent.withOpacity(0.6),
                //                                   borderRadius: BorderRadius.circular(4.0),
                //                                 ),
                //                               ),
                //                               Container(
                //                                 width: 29,
                //                                 child: Text(
                //                                   "lv.2:",
                //                                   style: TextStyle(fontSize: 14, color: Colors.grey),
                //                                 ),
                //                               ),
                //                               Text("600", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                       Gaps.vGap10,
                //                       Row(
                //                         children: [
                //                           Row(
                //                             children: [
                //                               Container(
                //                                 margin: const EdgeInsets.only(right: 4.0),
                //                                 width: 3.4,
                //                                 height: 20,
                //                                 decoration: BoxDecoration(
                //                                   color: Colors.blueAccent.withOpacity(0.9),
                //                                   borderRadius: BorderRadius.circular(4.0),
                //                                 ),
                //                               ),
                //                               Container(
                //                                 width: 26,
                //                                 child: Text(
                //                                   "lv.3:",
                //                                   style: TextStyle(fontSize: 14, color: Colors.grey),
                //                                 ),
                //                               ),
                //                               Text("700", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                             ],
                //                           ),
                //                           Gaps.hGap4,
                //                           Row(
                //                             children: [
                //                               Container(
                //                                 margin: const EdgeInsets.only(right: 4.0),
                //                                 width: 3.4,
                //                                 height: 20,
                //                                 decoration: BoxDecoration(
                //                                   color: Color.fromRGBO(238, 79, 34, 0.65),
                //                                   borderRadius: BorderRadius.circular(4.0),
                //                                 ),
                //                               ),
                //                               Container(
                //                                 width: 29,
                //                                 child: Text(
                //                                   "loss:",
                //                                   style: TextStyle(fontSize: 14, color: Colors.grey),
                //                                 ),
                //                               ),
                //                               Text("1444", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 )),
                //               ],
                //             ),
                //             Gaps.line,
                //             Gaps.line,
                //             Gaps.vGap10,
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                //               children: [
                //               // 排名
                //               Row(
                //                 children: [
                //                   SvgPicture.asset(width: 22, height: 22, "assets/images/customer-rate-svgrepo-com.svg",),
                //                   Gaps.hGap5,
                //                   Text("2/4", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                 ],
                //               ),
                //                 Row(
                //                   children: [
                //                     SvgPicture.asset(width: 22, height: 22, "assets/images/favourite-star-svgrepo-com.svg",),
                //                     Gaps.hGap5,
                //                     Text("lv.2", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                   ],
                //                 ),
                //                 Row(
                //                   children: [
                //                     SvgPicture.asset(width: 22, height: 22, "assets/images/money-card-credit-card-svgrepo-com.svg",),
                //                     Gaps.hGap5,
                //                     Text("3641", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                   ],
                //                 ),
                //                 Row(
                //                   children: [
                //                     SvgPicture.asset(width: 22, height: 22, "assets/images/off-button-power-button-svgrepo-com.svg",),
                //                     Gaps.hGap5,
                //                     Text("2000", style: TextStyle(fontSize: 14, color: Colors.black54)),
                //                   ],
                //                 ),
                //
                //
                //             ],)
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Expanded(child: Gaps.empty),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() {
    _shopPagePresenter = ShopPagePresenter();
    return _shopPagePresenter;
  }

  /// Show admin info dialog (same content as order list admin info dialog)
  Future<void> _showAdminInfoDialog() async {
    final ctx = context;
    final profile = ctx.read<UserProvider>().userEntity.profile;

    final name = profile?.aName ?? '--';
    final marketing = profile?.cRTodayMarketingCnt ?? 0;
    final weekCouponLeft = profile?.cLWeekCouponLeftCnt ?? 0;
    final weekExtendCnt = profile?.cNWeekExtendCnt ?? 0;
    final weekRetainLeft = profile?.cPWeekRetainLeftCnt ?? 0;
    final weekReceiveLeft = profile?.cQWeekReceiveLeftCnt ?? 0;
    final weekWaLeft = profile?.cJWeekWaLeftCnt ?? 0;

    final now = DateTime.now();
    final todayStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext dialogCtx) {
        final textStyle = Theme.of(dialogCtx).textTheme.bodyMedium;
        Widget row(String label, String value) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(child: Text(label, style: textStyle)),
                Text(value, style: textStyle),
              ],
            ),
          );
        }

        return AlertDialog(
          title: Text('Admin Info ($todayStr)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                row('Admin', name),
                const Divider(height: 16),
                row('New marketing cases today', marketing.toString()),
                row('Discount coupons remaining this week',
                    weekCouponLeft.toString()),
                row('Extensions remaining this week', weekExtendCnt.toString()),
                row('Retains available this week', weekRetainLeft.toString()),
                row('Receives available this week', weekReceiveLeft.toString()),
                row('WhatsApp applications available this week',
                    weekWaLeft.toString()),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // 构建表头单元格
  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.white70), // 单元格右侧边框
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 构建数据单元格
  Widget _buildDataCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.white70), // 单元格右侧边框
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 11)),
      ),
    );
  }
}

class _ShopFunctionModule extends StatelessWidget {
  const _ShopFunctionModule({
    required this.onItemClick,
    required this.data,
    required this.image,
    required this.darkImage,
  });

  final void Function(int index) onItemClick;
  final List<String> data;
  final List<String> image;
  final List<String> darkImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(
                  context.isDark
                      ? 'shop/${darkImage[index]}'
                      : 'shop/${image[index]}',
                  width: 32.0),
              Gaps.vGap4,
              Text(
                data[index],
                style: TextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}

class BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // 可以调整Path来定义边框形状
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(12)));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
