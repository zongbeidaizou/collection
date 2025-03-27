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
import '../../goods/goods_router.dart';
import '../../models/commission_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/page/order_page.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {

  const AccountRecordListPage({super.key});

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
      _accountRecordListPresenter.index(1, true);
    });
  }
  @override
  void didUpdateWidget(AccountRecordListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据

    _accountRecordListPresenter.index(1, false);
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


  }

  @override
  void setLogs(List<CommissionData> logs) {
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
    _accountRecordListPresenter.index(_currentPage,  true);
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color? iconColor = ThemeUtils.getIconColor(context);

    return Scaffold(
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
        title: Text("Commission Record",style: TextStyle(color: ThemeUtils.getIconColor(context))),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            onPressed: () {},
            icon: LoadAssetImage(
              'goods/search',
              key: const Key('search'),
              width: 24.0,
              // height: 24.0,
              color: iconColor,
            ),
          ),
        ],
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 120.0,
          child: CustomScrollView(
            slivers: _buildGroups(),
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

  Widget _buildItem(CommissionData log, int i) {
    return Container(
      height: 72.0,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: IndexedSemantics(
        index: i,
        child: Stack(
          children: <Widget>[
            Text( log.aAAAAABLCollectionOrder!.tBorrowSn!),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Text("+${log.hCommissionAmount}",
                style: i.isEven ? TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ) : TextStyles.textBold14,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Text(DateFormat('hh:mm a', 'en_US').format(DateTime.parse(log.createdAt!)), style: Theme.of(context).textTheme.titleSmall),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Text('lv.${log.kLevel} ${log.jRate}% of total amount ${log.gAmount}', style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
      ),
    );
  }


}
