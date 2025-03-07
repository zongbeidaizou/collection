import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/goods_router.dart';
import 'package:bounty_hunter/goods/page/goods_list_page.dart';
import 'package:bounty_hunter/goods/provider/goods_page_provider.dart';
import 'package:bounty_hunter/goods/widgets/goods_add_menu.dart';
import 'package:bounty_hunter/goods/widgets/goods_sort_menu.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/widgets/popup_window.dart';
import 'package:provider/provider.dart';

final List<IconData> _iconList = [Icons.all_inclusive,Icons.sync, Icons.more_time, Icons.do_not_touch, Icons.phone_disabled, Icons.hourglass_disabled, Icons.payment, Icons.check_circle, Icons.sms_outlined];
/// design/4商品/index.html
class GoodsPage extends StatefulWidget {

  const GoodsPage({super.key});

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController? _tabController;
  final PageController _pageController = PageController();

  final GlobalKey _addKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  GoodsPageProvider provider = GoodsPageProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 7);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  /// https://github.com/flutter/flutter/issues/72908
  @override
  // ignore: must_call_super
  void didChangeDependencies() {
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '搜索商品',
              onPressed: () => NavigatorUtils.push(context, GoodsRouter.goodsSearchPage),
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24.0,
                height: 24.0,
                color: iconColor,
              ),
            )
          ],
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: context.isDark ? Colours.text_gray : Colours.text,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(right: 4, left: 4),
                // 隐藏点击效果
                overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  return Colors.transparent;
                },
                ),
                tabs: const <Widget>[
                  _TabView('All', 0),
                  _TabView('Negotiation', 1),
                  _TabView('Promise', 2),
                  _TabView('Fraud', 3),
                  _TabView('No Answer', 4),
                  _TabView('Broken Promise', 5),
                  _TabView('SMS', 8),
                ],
              ),
            ),
            Gaps.line,
            Expanded(
              child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 7,
                  onPageChanged: _onPageChange,
                  controller: _pageController,
                  itemBuilder: (_, int index) => GoodsListPage(index: index)
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _tabController?.animateTo(index);
    provider.setIndex(index);
  }



  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {

  const _TabView(this.tabName, this.index);

  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(tabName, style: TextStyle(fontSize: 10)),
            Icon(_iconList[index], size: 12)
          ],
        ),
      ),
    );
  }
}
