import 'package:bounty_hunter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/page/order_list_page.dart';
import 'package:bounty_hunter/order/provider/order_page_provider.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/image_utils.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:bounty_hunter/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

import '../../providers/order_list_provider.dart';
import '../order_router.dart';

/// design/3订单/index.html
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with
        AutomaticKeepAliveClientMixin<OrderPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController? _tabController;
  OrderPageProvider provider = OrderPageProvider();
  UserProvider provider2 = UserProvider();
  OrderListProvider provider3 = OrderListProvider();

  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  void _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  /// https://github.com/simplezhli/bounty_hunter/issues/194
  @override
  // ignore: must_call_super
  void didChangeDependencies() {}

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = context.isDark;
    return
      MultiProvider(
          providers: [
            ChangeNotifierProvider<OrderPageProvider>(
                create: (_) => provider,
            )
          ],
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            /// 像素对齐问题的临时解决方法
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark
                    ? null
                    : const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colours.gradient_blue,
                            Color(0xFF4647FA)
                          ]),
                        ),
                      ),
              ),
            ),
            NestedScrollView(
              key: const Key('order_list'),
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  _sliverBuilder(context),
              body: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  /// PageView的onPageChanged是监听ScrollUpdateNotification，会造成滑动中卡顿。这里修改为监听滚动结束再更新、
                  if (notification.depth == 0 &&
                      notification is ScrollEndNotification) {
                    final PageMetrics metrics =
                        notification.metrics as PageMetrics;
                    final int currentPage = (metrics.page ?? 0).round();
                    if (currentPage != _lastReportedPage) {
                      _lastReportedPage = currentPage;
                      _onPageChange(currentPage);
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 5,
                  controller: _pageController,
                  itemBuilder: (_, index) => OrderListPage(index: index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          systemOverlayStyle: isDark ? ThemeUtils.light : ThemeUtils.dark,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              tooltip: '搜索',
              icon: LoadAssetImage(
                'order/icon_search',
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark
                ? Container(
                    height: 113.0,
                    color: Colours.dark_bg_color,
                  )
                : LoadAssetImage(
                    'order/order_bg',
                    width: context.width,
                    height: 113.0,
                    fit: BoxFit.fill,
                  ),
            centerTitle: true,
            titlePadding:
                const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text(
              '订单',
              style: TextStyle(color: ThemeUtils.getIconColor(context)),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? Colours.dark_bg_color : null,
              image: isDark
                  ? null
                  : DecorationImage(
                      image: ImageUtils.getAssetImage('order/order_bg1'),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: MyCard(
                child: Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor:
                        context.isDark ? Colours.dark_text : Colours.text,
                    unselectedLabelColor:
                        context.isDark ? Colours.dark_text_gray : Colours.text,
                    labelStyle: TextStyles.textBold14,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: Dimens.font_sp14,
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: const <Widget>[
                      _TabView(0, 'New', 10),
                      _TabView(1, 'Negotiating', 10),
                      _TabView(2, 'Promised', 10),
                      _TabView(3, 'Broken Promise', 10),
                      _TabView(4, 'Refused', 10),
                    ],
                    onTap: (index) {
                      if (!mounted) {
                        return;
                      }
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          80.0,
        ),
      ),
    ];
  }

  final PageController _pageController = PageController();
  Future<void> _onPageChange(int index) async {
    provider.setIndex(index);

    /// 这里没有指示器，所以缩短过渡动画时间，减少不必要的刷新
    _tabController?.animateTo(index, duration: Duration.zero);
  }
}

List<List<String>> img = [
  ['order/dwc_s', 'order/dwc_n'],
  ['order/xdd_s', 'order/xdd_n'],
  ['order/ywc_s', 'order/ywc_n'],
  ['order/dps_s', 'order/dps_n'],
  ['order/yqx_s', 'order/yqx_n']
];

List<List<String>> darkImg = [
  ['order/dark/icon_xdd_s', 'order/dark/icon_xdd_n'],
  ['order/dark/icon_dps_s', 'order/dark/icon_dps_n'],
  ['order/dark/icon_dwc_s', 'order/dark/icon_dwc_n'],
  ['order/dark/icon_ywc_s', 'order/dark/icon_ywc_n'],
  ['order/dark/icon_yqx_s', 'order/dark/icon_yqx_n']
];

class _TabView extends StatefulWidget {
  const _TabView(this.index, this.text, this.fontSize);

  final int index;
  final double fontSize;
  final String text;

  @override
  State<_TabView> createState() => _TabViewState();
}

class _TabViewState extends State<_TabView> {

  @override
  Widget build(BuildContext context) {
    final List<List<String>> imgList = context.isDark ? darkImg : img;
    return Stack(
      children: <Widget>[
        Container(
          width: 72.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              /// 使用context.select替代Consumer
              LoadAssetImage(
                context.select<OrderPageProvider, int>(
                            (value) => value.index) ==
                        widget.index
                    ? imgList[widget.index][0]
                    : imgList[widget.index][1],
                width: 24.0,
                height: 24.0,
              ),
              Gaps.vGap4,
              Text(
                widget.text,
                style: TextStyle(fontSize: widget.fontSize),
              ),
            ],
          ),
        ),
        Positioned(
          right: 6.0,
          child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.5, vertical: 2.0),
                    child:Consumer<UserProvider>(builder: (_, provider, __) {
                              if(widget.index == 0){
                                return Text(
                                  provider.userEntity.profile?.kCurrentNewCount?.toString()?? '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp12),
                                );
                              }else if(widget.index == 1){
                                return Text(
                                  provider.userEntity.profile?.lCurrentNegotiatingCount?.toString()?? '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp12),
                                );
                              }else if(widget.index == 2){
                                return Text(
                                  provider.userEntity.profile?.mCurrrentPromisedCount?.toString()?? '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp12),
                                );
                              }else if(widget.index == 3){
                                return Text(
                                  provider.userEntity.profile?.nCurrentBrokenCount?.toString()?? '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp12),
                                );
                              }
                              else if(widget.index == 4){
                                return Text(
                                  provider.userEntity.profile?.oCurrentRefusedCount?.toString()?? '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp12),
                                );
                              }
                              return Text(
                                "0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimens.font_sp12),
                              );

                        }),
                  ),
                )
              ,
        )
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
