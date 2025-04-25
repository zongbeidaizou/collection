import 'package:bounty_hunter/account/account_router.dart';
import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/account/presenter/account_record_list_presenter.dart';
import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../goods/goods_router.dart';
import '../../models/commission_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/page/order_page.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
const List<Color> bgColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Color(0xFFD4E2FA),
  Colors.greenAccent

];

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {

  const AccountRecordListPage({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<AccountRecordListPage> with AutomaticKeepAliveClientMixin<AccountRecordListPage>, SingleTickerProviderStateMixin,BasePageMixin<AccountRecordListPage, AccountRecordListPresenter>
    implements AccountRecordListMvpView{
  final GlobalKey _addKey = GlobalKey();
  late AccountRecordListPresenter _accountRecordListPresenter;
  late int _currentPage = 1;
  final List<CommissionData> _list = [];
  bool _isLoading = false;
  late int _maxPage;
  @override
  AccountRecordListPresenter createPresenter() {
    _accountRecordListPresenter = AccountRecordListPresenter();
    return _accountRecordListPresenter;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);

    });
  }
  @override
  void didUpdateWidget(AccountRecordListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据
    if (oldWidget.searchKeyword != widget.searchKeyword) {
      setState(() {
        _list.clear();
      });
      _accountRecordListPresenter.index(1,  false, keyword: widget.searchKeyword);
    }
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  @override
  void setAdmin(List<AdminData> admins) {
    // TODO: implement setAdmin
  }

  @override
  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }
  @override
  Future<void> _onRefresh() async {
    setState(() {
      _list.clear();
      _currentPage = 1;
    });
    _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);

  }

  @override
  void setLogs(List<CommissionData> logs, {bool clear = false}) {
    if (clear) {
      _list.clear();
    }
    setState(() {
      _list.addAll(logs);
      _isLoading = false;
    });
  }

  @override
  void setPageSize(int pageSize) {
    _maxPage = pageSize;
  }

  @override
  void setProduct(List<ProductData> product) {
    // TODO: implement setProduct
  }

  bool _hasMore() {
    return _currentPage < _maxPage;
  }

  Future<void> _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    setState(() {
      _currentPage ++;
    });
    _accountRecordListPresenter.index(_currentPage,  true, keyword: widget.searchKeyword);
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color? iconColor = ThemeUtils.getIconColor(context);

    return VisibilityDetector(
      key: Key('my-widget-key'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if(visiblePercentage >10 && context.read<RefreshProvider>().bonusRefresh){
          _onRefresh();
          context.read<RefreshProvider>().setBonusRefresh(false);
        }
      },
      child: Scaffold(
        appBar: widget.searchKeyword == '' ? AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colours.app_main,
          flexibleSpace: isDark ? Container(height: 115.0, color: Colours.dark_bg_color,) : LoadAssetImage('statistic/statistic_bg',
            width: context.width,
            height: 115.0,
            fit: BoxFit.fill,
          ),
          // toolbarHeight: 30,
          title: Text("Bonus Record",style: TextStyle(color: ThemeUtils.getIconColor(context))),
          actions: <Widget>[
            IconButton(
              tooltip: 'mark all as read',
              onPressed: () {
                _accountRecordListPresenter.markAsRead(true);
              },
              icon: Icon(Icons.remove_red_eye_outlined,color: Colors.black54,),
            ),
            IconButton(
              tooltip: 'Search',
              onPressed: () {
                NavigatorUtils.push(context, AccountRouter.search);
              },
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24.0,
                // height: 24.0,
                color: iconColor,
              ),
            ),
          ],
        ): null,
        body: NotificationListener(
          onNotification: (ScrollNotification note) {
            if (note.metrics.pixels == note.metrics.maxScrollExtent) {
              _loadMore();
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 20.0,
            child: CustomScrollView(
              slivers: _list.isNotEmpty ? _buildGroups() : [const SliverFillRemaining(child: Center(child: Text('no data, search by phone or sn')))],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGroups() {
    // 按日期分组
    final Map<String, List<CommissionData>> groupedLog = {};
    for (final CommissionData log in _list) {
      final DateTime createdAt = DateTime.parse(log.createdAt!);

      // 将日期格式化为年月日字符串
      String date = DateFormat('MMM d', 'en_US').format(createdAt);
      if (!groupedLog.containsKey(date)) {
        groupedLog[date] = [];
      }
      groupedLog[date]!.add(log);
    }

    // 生成Sliver列表
    return groupedLog.entries.map((entry) {
      String date = entry.key;
      List<CommissionData> logList = entry.value;
      return SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: ThemeUtils.getStickyHeaderColor(context),
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(date,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              34.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, index) {
                return _buildItem(logList[index], index);
              },
              childCount: logList.length,
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildGoodsTag(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp10, height:  1.1 ,),
      ),
    );
  }

  Widget _buildItem(CommissionData log, int i) {
    String txt = '${log.jRate}% of total amount ${log.gAmount} (lv.${log.kLevel})';
    if(log.oType == 2){
      txt = "Tiered Achievement Bonus (lv.${log.kLevel})";
    }else if(log.oType == 3){
      txt = "Manually Calculated Bonus";
    }

    return Container(
      height: 72.0,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: bgColors[log.oType!],
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: IndexedSemantics(
        index: i,
        child: Stack(
          children: <Widget>[
            Row(
              children: [
                Gaps.hGap32,
                Text( log.aAAAAABLCollectionOrder!.tBorrowSn!),
                Gaps.hGap4,
                Row(
                  children: <Widget>[
                    Offstage(
                      offstage: !(log.oType == 2) ,
                      child: _buildGoodsTag(Theme.of(context).colorScheme.error, 'Achievement Bonus'),
                    ),
                    Offstage(
                      offstage: !(log.oType == 3) ,
                      child: _buildGoodsTag(Theme.of(context).primaryColor, 'Manually Bonus'),
                    ),
                    Offstage(
                      offstage: !(log.wReaded == 0) ,
                      child: _buildGoodsTag(Colors.green, 'New'),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Text("+${log.hCommissionAmount}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ) ,
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 0.0,
              child: Center(child: Text(log.yDayIndex!.toString(), style: TextStyle(fontSize: 14,color: Colors.grey.shade500))),
            ),
            Positioned(
              bottom: 0.0,
              left: 32.0,
              child: Text(DateFormat('hh:mm a', 'en_US').format(DateTime.parse(log.createdAt!)), style: Theme.of(context).textTheme.titleSmall),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Text(txt, style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
      ),
    );
  }


}
