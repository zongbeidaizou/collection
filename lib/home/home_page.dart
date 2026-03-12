import 'package:bounty_hunter/shop/page/marketing_page.dart';
import 'package:bounty_hunter/shop/page/review_page.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/page/goods_page.dart';
import 'package:bounty_hunter/home/provider/home_provider.dart';
import 'package:bounty_hunter/order/page/order_page.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/shop/page/shop_page.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/double_tap_back_exit_app.dart';
import 'package:provider/provider.dart';

import '../account/page/account_record_list_page.dart';
import '../providers/user_provider.dart';
import '../shop/page/message_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RestorationMixin {
  static const double _imageSize = 25.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = [
    'Cases',
    'Verify',
    'Marketing',
    'Logs',
    'Bonus',
    'News',
    'Account'
  ];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const OrderPage(),
      const ReviewPage(),
      const MarketingPage(),
      const GoodsPage(),
      const AccountRecordListPage(searchKeyword: ''),
      const MessagePage(),
      const ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem(
      int aGCollectionCommissionNewCount,
      int aHCollectionNotificationCount,
      int cRTodayMarketingCnt) {
    // if (_list == null) {
    var tabImages = [
      const [
        Icon(
          Icons.app_registration_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.app_registration_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      const [
        Icon(
          Icons.fact_check,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.fact_check,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.tty,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (cRTodayMarketingCnt <= 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        cRTodayMarketingCnt.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.tty,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (cRTodayMarketingCnt <= 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        cRTodayMarketingCnt.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      const [
        Icon(
          Icons.flag_circle_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.flag_circle_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.iso,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (aGCollectionCommissionNewCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 0.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aGCollectionCommissionNewCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.iso,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (aGCollectionCommissionNewCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 0.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aGCollectionCommissionNewCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.campaign_sharp,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (aHCollectionNotificationCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aHCollectionNotificationCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.campaign_sharp,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (aHCollectionNotificationCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aHCollectionNotificationCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      const [
        Icon(
          Icons.emoji_events_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.emoji_events_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ]
    ];
    _list = List.generate(tabImages.length, (i) {
      return BottomNavigationBarItem(
        icon: tabImages[i][0],
        activeIcon: tabImages[i][1],
        label: _appBarTitles[i],
        tooltip: _appBarTitles[i],
      );
    });
    // }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem(
      int aGCollectionCommissionNewCount,
      int aHCollectionNotificationCount,
      int cRTodayMarketingCnt) {
    // if (_list == null) {
    var tabImages = [
      const [
        Icon(
          Icons.app_registration_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.app_registration_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      const [
        Icon(
          Icons.fact_check,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.fact_check,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.tty,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (cRTodayMarketingCnt <= 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        cRTodayMarketingCnt.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.tty,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (cRTodayMarketingCnt <= 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        cRTodayMarketingCnt.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      const [
        Icon(
          Icons.flag_circle_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.flag_circle_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.iso,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (aGCollectionCommissionNewCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 0.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aGCollectionCommissionNewCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.iso,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (aGCollectionCommissionNewCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 0.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aGCollectionCommissionNewCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      [
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.campaign_sharp,
                  size: _imageSize,
                  color: Colours.unselected_item_color,
                ),
              ),
              if (aHCollectionNotificationCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aHCollectionNotificationCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 56,
          child: Stack(
            children: <Widget>[
              Center(
                child: const Icon(
                  Icons.campaign_sharp,
                  size: _imageSize,
                  color: Colours.app_main,
                ),
              ),
              if (aHCollectionNotificationCount == 0)
                const SizedBox()
              else
                Positioned(
                  right: 4.2,
                  top: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.5, vertical: 1.0),
                      child: Text(
                        aHCollectionNotificationCount.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      const [
        Icon(
          Icons.emoji_events_rounded,
          size: _imageSize,
          color: Colours.unselected_item_color,
        ),
        Icon(
          Icons.emoji_events_rounded,
          size: _imageSize,
          color: Colours.app_main,
        ),
      ]
    ];
    _list = List.generate(tabImages.length, (i) {
      return BottomNavigationBarItem(
        icon: tabImages[i][0],
        activeIcon: tabImages[i][1],
        label: _appBarTitles[i],
        tooltip: _appBarTitles[i],
      );
    });
    // }
    return _list!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
            bottomNavigationBar: Consumer2<HomeProvider, UserProvider>(
              builder: (_, provider, provider2, __) {
                return BottomNavigationBar(
                  backgroundColor: context.backgroundColor,
                  items: isDark
                      ? _buildDarkBottomNavigationBarItem(
                          provider2.userEntity.profile
                                  ?.aGCollectionCommissionNewCount ??
                              0,
                          provider2.userEntity.profile
                                  ?.aHCollectionNotificationCount ??
                              0,
                          provider2.userEntity.profile?.cRTodayMarketingCnt ?? 0)
                      : _buildBottomNavigationBarItem(
                          provider2.userEntity.profile
                                  ?.aGCollectionCommissionNewCount ??
                              0,
                          provider2.userEntity.profile
                                  ?.aHCollectionNotificationCount ??
                              0,
                          provider2.userEntity.profile?.cRTodayMarketingCnt ?? 0),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: provider.value,
                  elevation: 5.0,
                  iconSize: 21.0,
                  selectedFontSize: Dimens.font_sp10,
                  unselectedFontSize: Dimens.font_sp10,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: isDark
                      ? Colours.dark_unselected_item_color
                      : Colours.unselected_item_color,
                  onTap: (index) => _pageController.jumpToPage(index),
                );
              },
            ),
            // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
            body: PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
              controller: _pageController,
              onPageChanged: (int index) => provider.value = index,
              children: _pageList,
            )),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}
