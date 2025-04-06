import 'package:bounty_hunter/shop/widgets/pie2.dart';
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
import 'package:provider/provider.dart';

import '../../models/shop_entity.dart';
import '../../providers/user_provider.dart';
import '../widgets/bar.dart';
import '../widgets/bar2.dart';
import '../widgets/level_bar.dart';
import '../widgets/line.dart';
import '../widgets/pie.dart';

const List<Map<String, dynamic>> hallData = [
  {'name': 'Tom', 'value': 160, 'avatar': 'https://api.dasewan.cn/assets/avater1.png'},
  {'name': 'Jerry', 'value': 142, 'avatar': 'https://api.dasewan.cn/assets/avater2.png'},
  {'name': 'Spike', 'value': 120, 'avatar': 'https://api.dasewan.cn/assets/avater3.png'},
  {'name': 'Tyke', 'value': 110, 'avatar': 'https://api.dasewan.cn/assets/avater4.png'},
  {'name': 'Tyke', 'value': 110, 'avatar': 'https://api.dasewan.cn/assets/avater5.png'},
  {'name': 'Tyke', 'value': 110, 'avatar': 'https://api.dasewan.cn/assets/avater6.png'},
  {'name': 'Tyke', 'value': 110, 'avatar': 'https://api.dasewan.cn/assets/avater7.png'},
  {'name': 'Tyke', 'value': 110, 'avatar': 'https://api.dasewan.cn/assets/avater8.png'},

];
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

class _ShopPageState extends State<ShopPage> with BasePageMixin<ShopPage, ShopPagePresenter>, AutomaticKeepAliveClientMixin<ShopPage>, SingleTickerProviderStateMixin implements ShopIMvpView {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  ShopData _data = ShopData.fromJson({"web_url":"","other":{"progress":{"points":[0,1],"levelProgress":[],"amountProgress":[],"amountProgress2":[0,0,0,0,0],"currentLevel":1,"nextAmount":0,"nextLevel":1,"currentKey":0},"profile":{}},"show_month_data":false,"month_data":[],"show_week_case_data":false,"week_case_data":[],"show_week_bonus_data":false,"week_bonus_data":[],"show_month_case_data":false,"month_case_data":[],"show_month_bonus_data":false,"month_bonus_data":[]});

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
  void setData(ShopData data){
    _data = data;
    setState(() {

    });
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
    ).animate(onPlay: (controller) => controller.repeat())
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
            child: Text(
              "Hi Jacob",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        leadingWidth: 300,
        actions: <Widget>[
          IconButton(
            tooltip: 'Setting',
            onPressed: () {
              NavigatorUtils.push(context, SettingRouter.settingPage);
            },
            icon: LoadAssetImage(
              'shop/setting',
              key: const Key('setting'),
              width: 24.0,
              height: 24.0,
              color: iconColor,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey]
                : [Colors.indigoAccent, Colors.indigoAccent.withOpacity(0.52), Colors.indigoAccent.withOpacity(0.44), Colors.indigoAccent.withOpacity(0.3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // level your current hunt level is lv.1 with 4% of amount, collection more 5000 can touch lv2 with 6% of amount
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child:Consumer<UserProvider>(builder: (_, provider, __) {
                    return LevelBar(data: provider.userEntity.progress!);
                  }),
                  ),
              Gaps.vGap8,
              // 名人堂
              MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'This Month\'s Collector Hall of Fame',
                        style: TextStyles.textBold16,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _data.monthData!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Color iconColor = Colors.transparent;
                    if (index == 0) {
                      iconColor = Colors.yellow.withOpacity(0.8);
                    } else if (index == 1) {
                      iconColor = Color(0xFFC0C0C0).withOpacity(0.8);
                    } else if (index == 2) {
                      iconColor = Color(0xFFB87333).withOpacity(0.8);
                    }
                    return index < 3 ? AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {

                      return Container(
                        padding: EdgeInsets.all(8.0),
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
                                  effects: [FadeEffect(), ScaleEffect()],
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
                                      radius: 28.0,
                                      backgroundColor: Colors.transparent,
                                      // backgroundImage: ImageUtils.getAssetImage('avater/avater${index + 1}'),
                                      backgroundImage: ImageUtils.getImageProvider(_data.monthData![index].avatar, holderImg: 'store/icon_zj'),
                                      // backgroundImage: LoadImage(item.icon, width: 72.0, height: 72.0),,
                                    ),
                                  ).animate(onPlay: (controller) => controller.repeat())
                                      .shimmer(duration: 2200.ms, color: Colors.white.withOpacity(0.5))
                                      .animate() // this wraps the previous Animate in another Animate
                                      .fadeIn(duration: 2200.ms, curve: Curves.easeOutQuad)
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
                            SizedBox(height: 8.0),
                            Text(formatNumberToK(_data.monthData![index].value!)),
                          ],
                        ),
                      );
                    }) :
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.transparent!,
                                    width: 4.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 28.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: ImageUtils.getImageProvider(hallData[index]['avatar'] as String, holderImg: 'store/icon_zj'),
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
                          SizedBox(height: 8.0),
                          Text('${hallData[index]['value']}K'),
                        ],
                      ),
                    );

                  },
                ),
              ),

              if (_data.showWeekBonusData!) Bar2(weekBonusData: _data.weekBonusData!,weekCaseData: _data.weekCaseData!,) else Gaps.empty,
              // 统计
              LineChartSample1(monthBonusData: _data.monthBonusData!,monthCaseData: _data.monthCaseData!,),
              // BarChartSample3(),
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
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() => ShopPagePresenter();
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
              LoadAssetImage(context.isDark ? 'shop/${darkImage[index]}' : 'shop/${image[index]}', width: 32.0),
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
    Path path = Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(12)));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
