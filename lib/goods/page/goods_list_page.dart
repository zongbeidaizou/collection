import 'package:bounty_hunter/goods/iview/goods_list_iview.dart';
import 'package:bounty_hunter/goods/presenter/goods_list_presenter.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/models/goods_item_entity.dart';
import 'package:bounty_hunter/goods/provider/goods_page_provider.dart';
import 'package:bounty_hunter/res/constant.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_refresh_list.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/collection_log2_entity.dart';
import '../../mvp/base_page.dart';
import '../../util/theme_utils.dart';
import '../goods_router.dart';
import '../widgets/goods_delete_bottom_sheet.dart';
import '../widgets/goods_item.dart';

class GoodsListPage extends StatefulWidget {

  const GoodsListPage({
    super.key,
    required this.index
  });

  final int index;

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> with AutomaticKeepAliveClientMixin<GoodsListPage>, SingleTickerProviderStateMixin,BasePageMixin<GoodsListPage, GoodsListPresenter>
    implements GoodsListMvpView {

  int _page = 1;
  late int _maxPage;
  StateType _stateType = StateType.loading;
  bool _isLoading = false;
  List<CollectionLog2Data> _logList = [];
  late GoodsListPresenter _goodsListPresenter;

  @override
  void initState() {
    super.initState();


    _onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  GoodsListPresenter createPresenter() {
    _goodsListPresenter = GoodsListPresenter();
    return _goodsListPresenter;
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }


  @override
  void setLogs(List<CollectionLog2Data> logs) {
    setState(() {
      _logList.addAll(logs);
      _isLoading = false;
    });
  }
  @override
  Future<void> _onRefresh() async {
/*    CollectionLog2Entity response = await _goodsListPresenter.index(1, widget.index, true);
    _logList = response.data!;
    setState(() {
      _page = 1;
    });*/
  }

  bool _hasMore() {
    return _page < _maxPage;
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
      _page ++;
    });
    _goodsListPresenter.index(2, widget.index, true);
  }

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
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
    );
  }

  List<Widget> _buildGroups() {
    // 按日期分组
    final Map<String, List<CollectionLog2Data>> groupedLog = {};
    for (final CollectionLog2Data log in _logList) {
      final DateTime createdAt = DateTime.parse(log.createdAt!);

      // 将日期格式化为年月日字符串
      String date = DateFormat('yyyy-MM-dd').format(createdAt);
      if (!groupedLog.containsKey(date)) {
        groupedLog[date] = [];
      }
      groupedLog[date]!.add(log);
    }

    // 生成Sliver列表
    return groupedLog.entries.map((entry) {
      String date = entry.key;
      List<CollectionLog2Data> logList = entry.value;
      return SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: ThemeUtils.getStickyHeaderColor(context),
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(date),
              ),
              34.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, index) {
                return _buildItem(logList[index]);
              },
              childCount: logList.length,
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildItem(CollectionLog2Data transaction) {
    return Container(
      height: 72.0,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: Text("123")
    );
  }





}
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SliverAppBarDelegate(this.child, this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
