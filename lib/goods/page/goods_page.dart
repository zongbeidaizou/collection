import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/goods_router.dart';
import 'package:bounty_hunter/goods/page/goods_list_page.dart';
import 'package:bounty_hunter/goods/provider/goods_page_provider.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:provider/provider.dart';

final List<IconData> _iconList = [
  Icons.miscellaneous_services, //0 系统自动分配
  Icons.sync, //1 协商中
  Icons.more_time, //2 承诺还款
  Icons.hourglass_disabled, //3 承诺未还
  Icons.hourglass_disabled, //4 
  Icons.phone_disabled, //5 
  Icons.nightlight, //6 部分支付
  Icons.payment, //7 
  Icons.check_circle, //8 
  Icons.sms_outlined, //9 
  Icons.extension_outlined, //10 展期成功
  Icons.repeat_one, //11 保留
  Icons.move_up, //12 接收
  Icons.loupe, //13 管理员分配
  Icons.sms_outlined, //14 
  Icons.sms_outlined, //15 
  Icons.sms_outlined, //16 
  Icons.sms_outlined, //17 
];
  final List<Color> _colorList = [
    Colors.blue, //0系统分配
    Colors.grey, //1协商中
    Colors.green, //2承诺还款
    Colors.orange, //3承诺未还
    Colors.red, //4无法联系
    Colors.red, //5部分还款
    const Color.fromARGB(255, 137, 139, 141), //6部分还款
    Colors.green, //7已还款
    Colors.grey, //8短信
    Colors.grey, //9外呼
    const Color.fromARGB(255, 128, 188, 225), //10展期
    Colors.green, //11保留
    Colors.purple, //12领取
    Colors.blue, //13管理员
  ];
/// design/4商品/index.html
class GoodsPage extends StatefulWidget {

  const GoodsPage({super.key});

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController? _tabController;
  final PageController _pageController = PageController();

  final GlobalKey _bodyKey = GlobalKey();
  String _searchKeyword = ''; // 管理搜索关键词的状态
  final TextEditingController _controller = TextEditingController();

  GoodsPageProvider provider = GoodsPageProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 8);
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
  void _updateSearchKeyword(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        //todo 搜索
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: () => NavigatorUtils.goBack(context),
            icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colours.app_main,
          flexibleSpace:  LoadAssetImage('statistic/statistic_bg',
            height: 115.0,
            fit: BoxFit.fill,
          ),
          // toolbarHeight: 30,
          title: Text("Logs",style: TextStyle(color: ThemeUtils.getIconColor(context))),
          actions: <Widget>[
            IconButton(
              tooltip: 'Search',
              onPressed: () {
                NavigatorUtils.push(context, GoodsRouter.goodsSearchPage);
              },
              icon: Icon(Icons.content_paste_search_outlined, color: Colors.white,),
            ),
          ],
        ),
        // appBar: AppBar(
        //   actions: <Widget>[
        //
        //   ],
        // ),
        body: Consumer<GoodsPageProvider>(
          builder: (context, pageProvider, _) => Column(
            key: _bodyKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
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
                // 选中颜色改为每个 Tab 自己控制（见 _TabView），这里不再用全局 labelColor
                indicatorPadding: const EdgeInsets.only(right: 1, left: 1),
                // 隐藏点击效果
                overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  return Colors.transparent;
                },
                ),
                tabs: List<Widget>.generate(8, (tabIndex) {
                  final selected = pageProvider.index == tabIndex;
                  final unselectedColor = context.isDark ? Colours.text_gray : Colours.text;

                  switch (tabIndex) {
                    case 0:
                      return _TabView('BP', 3, selected: selected, unselectedColor: unselectedColor); // 承诺未还
                    case 1:
                      return _TabView('Part Pay', 6, selected: selected, unselectedColor: unselectedColor); // 部分支付
                    case 2:
                      return _TabView('PTP', 2, selected: selected, unselectedColor: unselectedColor); // 承诺还款
                    case 3:
                      return _TabView('Extension', 10, selected: selected, unselectedColor: unselectedColor); // 展期成功
                    case 4:
                      return _TabView('Retain', 11, selected: selected, unselectedColor: unselectedColor); // 保留
                    case 5:
                      return _TabView('Receive', 12, selected: selected, unselectedColor: unselectedColor); // 接收
                    case 6:
                      return _TabView('Admin', 13, selected: selected, unselectedColor: unselectedColor); // 管理员分配
                    case 7:
                    default:
                      return _TabView('Negotiation', 1, selected: selected, unselectedColor: unselectedColor); // 协商中
                  }
                }),
                ),
              ),
              Gaps.line,
              Expanded(
                child: PageView.builder(
                    key: const Key('pageView'),
                    itemCount: 8,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, int index) => GoodsListPage(index: index, searchKeyword: _searchKeyword,)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _controller.text='';
    _tabController?.animateTo(index);
    provider.setIndex(index);
  }



  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {

  const _TabView(
    this.tabName,
    this.index, {
    required this.selected,
    required this.unselectedColor,
  });

  final String tabName;
  final int index;
  final bool selected;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = _colorList[index];
    final Color color = selected ? selectedColor : unselectedColor;

    return Tab(
      child: SizedBox(
        width: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(tabName, style: TextStyle(fontSize: 10, color: color)),
            Icon(_iconList[index], size: 14, color: color)
          ],
        ),
      ),
    );
  }
}
