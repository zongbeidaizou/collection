import 'dart:io' show Platform;

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
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../goods/goods_router.dart';
import '../../providers/order_list_provider.dart';
import '../order_router.dart';

final List<IconData> _iconList = [
  Icons.play_for_work_sharp,
  Icons.sync,
  Icons.more_time,
  Icons.timer_off_outlined,
  Icons.phone_disabled,
  // Icons.pest_control,
  Icons.hourglass_disabled,
  Icons.payment,
  Icons.check_circle,
  Icons.sms_outlined
];

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
  OrderListProvider provider3 = OrderListProvider();

  int _lastReportedPage = 0;
  int _sloganIndex = 0;

  final TextEditingController _phoneFilterController = TextEditingController();
  String _phoneFilterKeyword = '';

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

  Future<void> _addAllContacts(BuildContext ctx) async {
    if (!Platform.isAndroid) {
      showToast('Adding to contacts is supported on Android only');
      return;
    }

    final PermissionStatus status = await Permission.contacts.request();
    if (!status.isGranted) {
      showToast('Please grant contacts permission first');
      return;
    }

    // 弹出输入框，允许用户自定义 label 和 company（应用到本次批量添加的所有联系人）
    final labelController = TextEditingController(text: 'Collection');
    final companyController = TextEditingController(text: 'Collection');

    final bool? confirmed = await showDialog<bool>(
      context: ctx,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add all cases contacts to phone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
              TextField(
                controller: companyController,
                decoration: const InputDecoration(labelText: 'Company'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    final String label =
        labelController.text.trim().isEmpty ? 'Collection' : labelController.text.trim();
    final String company =
        companyController.text.trim().isEmpty ? 'Collection' : companyController.text.trim();

    final orderListProvider = ctx.read<OrderListProvider>();
    final contacts = orderListProvider.list
        .where((item) => (item.uPhone ?? '').isNotEmpty)
        .toList();

    if (contacts.isEmpty) {
      showToast('No contacts to add');
      return;
    }

    const MethodChannel contactChannel = MethodChannel('contact_channel');
    int successCount = 0;

    for (final item in contacts) {
      final phone = item.uPhone ?? '';
      final name = item.vName ?? '';
      try {
        await contactChannel.invokeMethod('addContact', {
          'name': 'z-$name',
          'phone': phone,
          'label': label,
          'company': company,
        });
        successCount++;
      } catch (_) {
        // Ignore individual failures, continue with others
      }
    }

    showToast('Added $successCount contacts');
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _phoneFilterController.dispose();
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
    return MultiProvider(
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
                  _sliverBuilder(context, _sloganIndex),
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
                      setState(() {
                        _sloganIndex = currentPage;
                      });
                      _onPageChange(currentPage);
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 5,
                  controller: _pageController,
                  itemBuilder: (_, index) => OrderListPage(
                    index: index,
                    keyword: _phoneFilterKeyword,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, int sloganIndex) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          systemOverlayStyle: isDark ? ThemeUtils.light : ThemeUtils.dark,
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: _phoneFilterController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.phone,
                  onChanged: (val) {
                    setState(() {
                      _phoneFilterKeyword = val;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Filter phone',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    suffixIcon: _phoneFilterKeyword.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _phoneFilterController.clear();
                              setState(() {
                                _phoneFilterKeyword = '';
                              });
                            },
                          ),
                    filled: true,
                    fillColor: isDark
                        ? Colors.black.withOpacity(0.30)
                        : Colors.white.withOpacity(0.70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _addAllContacts(context);
              },
              tooltip: 'Add Contact',
              icon: Icon(Icons.group_add, size: 30.0, color: ThemeUtils.getIconColor(context)),
            ),
             IconButton(
              onPressed: () {
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              tooltip: 'Search',
              icon: Icon(Icons.search, size: 30.0, color: ThemeUtils.getIconColor(context)),
            ),
            
             IconButton(
              onPressed: () {
                NavigatorUtils.push(context, GoodsRouter.goodsPage);
              },
              tooltip: 'Receive',
              icon: Icon(Icons.description_outlined, size: 28.0, color: ThemeUtils.getIconColor(context)),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 1.0, // 不随着滑动隐藏标题
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
              // 'Every call is a chance to collect—did you move closer to your goal today?',
              // 'No account left behind, no payment lost!',
              // 'Hang-ups don’t hurt—what hurts is giving up!',
              // 'The golden 48 hours—miss them, lose the payment!',
              // 'More calls today, bigger paychecks tomorrow!',
              // 'Average collectors earn flat rates. Elite collectors earn exponential rewards!',
              // messages[Random().nextInt(messages.length)],
              '',
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
                      _TabView(2, 'PTP', 10),
                      _TabView(3, 'BP', 10),
                      _TabView(4, 'No Answer', 10),
                      // _TabView(5, 'Fraud', 10),
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
    return Stack(
      children: <Widget>[
        Container(
          width: 72.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              /// 使用context.select替代Consumer
              SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                      child: Icon(_iconList[widget.index],
                          size: context.select<OrderPageProvider, int>(
                                      (value) => value.index) ==
                                  widget.index
                              ? 30
                              : 20,
                          weight: context.select<OrderPageProvider, int>(
                                      (value) => value.index) ==
                                  widget.index
                              ? 800
                              : 400,
                          color: context.select<OrderPageProvider, int>(
                                      (value) => value.index) ==
                                  widget.index
                              ? Colors.blue
                              : Colors.grey))),

              // LoadAssetImage(
              //   context.select<OrderPageProvider, int>(
              //               (value) => value.index) ==
              //           widget.index
              //       ? imgList[widget.index][0]
              //       : imgList[widget.index][1],
              //   width: 24.0,
              //   height: 24.0,
              // ),
              Gaps.vGap4,
              Text(
                widget.text,
                style: context.select<OrderPageProvider, int>(
                            (value) => value.index) ==
                        widget.index
                    ? TextStyle(fontSize: 10, color: Colors.blue)
                    : TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        Positioned(
          right: 6.0,
          child: Consumer<UserProvider>(builder: (_, provider, __) {
            if (widget.index == 0 &&
                ((provider.userEntity.profile?.kCurrentNewCount ?? 0) != 0)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.5, vertical: 2.0),
                  child: Text(
                    provider.userEntity.profile?.kCurrentNewCount?.toString() ??
                        '0',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  ),
                ),
              );
            } else if (widget.index == 1 &&
                ((provider.userEntity.profile?.lCurrentNegotiatingCount ?? 0) !=
                    0)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.5, vertical: 2.0),
                  child: Text(
                    provider.userEntity.profile?.lCurrentNegotiatingCount
                            ?.toString() ??
                        '0',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  ),
                ),
              );
            } else if (widget.index == 2 &&
                ((provider.userEntity.profile?.mCurrrentPromisedCount ?? 0) !=
                    0)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.5, vertical: 2.0),
                  child: Text(
                    provider.userEntity.profile?.mCurrrentPromisedCount
                            ?.toString() ??
                        '0',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  ),
                ),
              );
            } else if (widget.index == 3 &&
                ((provider.userEntity.profile?.nCurrentBrokenCount ?? 0) !=
                    0)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.5, vertical: 2.0),
                  child: Text(
                    provider.userEntity.profile?.nCurrentBrokenCount
                            ?.toString() ??
                        '0',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  ),
                ),
              );
            } else if (widget.index == 4 &&
                ((provider.userEntity.profile?.oCurrentRefusedCount ?? 0) !=
                    0)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.5, vertical: 2.0),
                  child: Text(
                    provider.userEntity.profile?.oCurrentRefusedCount
                            ?.toString() ??
                        '0',
                    style: const TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  ),
                ),
              );
            } else {
              return Gaps.empty;
            }
          }),
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
