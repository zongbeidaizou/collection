import 'package:bounty_hunter/goods/page/record_tracking_page.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/goods_router.dart';
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


/// design/4商品/index.html
class GoodsPage extends StatefulWidget {

  const GoodsPage({super.key});

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {


  final PageController _pageController = PageController();

  final GlobalKey _addKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();

  GoodsPageProvider provider = GoodsPageProvider();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// https://github.com/flutter/flutter/issues/72908
  @override
  // ignore: must_call_super
  void didChangeDependencies() {
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colours.app_main,
          flexibleSpace: isDark ? Container(height: 115.0, color: Colours.dark_bg_color,) : LoadAssetImage('statistic/statistic_bg',
            width: context.width,
            height: 115.0,
            fit: BoxFit.fill,
          ),
          // toolbarHeight: 30,
          title: Text("My Logs",style: TextStyle(color: ThemeUtils.getIconColor(context))),
          actions: <Widget>[
            IconButton(
              tooltip: '搜索商品',
              onPressed: () => NavigatorUtils.push(context, GoodsRouter.goodsSearchPage),
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24.0,
                // height: 24.0,
                color: iconColor,
              ),
            ),
            IconButton(
              tooltip: '添加商品',
              key: _addKey,
              onPressed: _showAddMenu,
              icon: LoadAssetImage(
                'goods/add',
                key: const Key('add'),
                width: 24.0,
                // height: 24.0,
                color: iconColor,
              ),
            )
          ],
        ),
        body: RecordTrackingPage(),
      ),
    );
  }


  /// design/4商品/index.html#artboard4
  void _showAddMenu() {
    final RenderBox button = _addKey.currentContext!.findRenderObject()! as RenderBox;

    showPopupWindow<void>(
      context: context,
      isShowBg: true,
      offset: Offset(button.size.width - 8.0, -12.0),
      anchor: button,
      child: const GoodsAddMenu(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

