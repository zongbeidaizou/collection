import 'package:bounty_hunter/goods/iview/goods_list_iview.dart';
import 'package:bounty_hunter/goods/presenter/goods_list_presenter.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:clipboard/clipboard.dart';
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

import '../../models/admin_entity.dart';
import '../../models/collection_log2_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/order_router.dart';
import '../../order/widgets/add_note.dart';
import '../../res/colors.dart';
import '../../res/dimens.dart';
import '../../res/gaps.dart';
import '../../util/theme_utils.dart';
import '../goods_router.dart';
import '../widgets/goods_delete_bottom_sheet.dart';
import '../widgets/goods_item.dart';

final List<IconData> _iconList = [
  Icons.input,
  Icons.sync,
  Icons.more_time,
  Icons.hourglass_disabled,
  Icons.phone_disabled,
  Icons.transfer_within_a_station,
  Icons.payment,
  Icons.check_circle,
  Icons.sms_outlined
];
final List<Color> _colorList = [
  Colors.brown,
  Colors.grey,
  Colors.blue,
  Colors.purpleAccent,
  Colors.red,
  Colors.orange,
  Colors.green,
  const Color(0xFF1B5E20),
  Colors.blueGrey,
];
final List<int> _typeList = [0, 1, 2, 3, 4, 5, 8];

class GoodsListPage extends StatefulWidget {
  const GoodsListPage(
      {super.key, required this.index, required this.searchKeyword});

  final int index;
  final String searchKeyword;

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage>
    with
        AutomaticKeepAliveClientMixin<GoodsListPage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<GoodsListPage, GoodsListPresenter>
    implements GoodsListMvpView {
  late int _maxPage;
  late int _currentPage = 1;
  StateType _stateType = StateType.loading;
  bool _isLoading = false;
  List<CollectionLog2Data> _logList = [];
  late GoodsListPresenter _goodsListPresenter;
  List<ProductData> _products = <ProductData>[];
  List<AdminData> _admins = <AdminData>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _goodsListPresenter.index(1, _typeList[widget.index], true,
          keyword: widget.searchKeyword);
    });
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
  void didUpdateWidget(GoodsListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据
    if (oldWidget.searchKeyword != widget.searchKeyword) {
      setState(() {
        _logList.clear();
      });
      _goodsListPresenter.index(1, _typeList[widget.index], false,
          keyword: widget.searchKeyword);
    }
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
    setState(() {
      _logList.clear();
      _currentPage = 1;
    });
    await _goodsListPresenter.index(1, _typeList[widget.index], false,
        keyword: widget.searchKeyword);
  }

  @override
  void setPageSize(int pageSize) {
    _maxPage = pageSize;
  }

  @override
  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  @override
  void setProduct(List<ProductData> products) {
    _products = products;
  }

  @override
  void setAdmin(List<AdminData> admin) {
    _admins = admin;
  }

  bool _hasMore() {
    return _currentPage < _maxPage;
  }

  Future<void> _loadMore() async {
    Toast.show(widget.index.toString());
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    setState(() {
      _currentPage++;
    });
    _goodsListPresenter.index(_currentPage, _typeList[widget.index], true);
  }

  @override
  bool get wantKeepAlive => true;

  void _showModalBottomSheet(CollectionOrderData item) {
    NavigatorUtils.push(context,
        '${OrderRouter.notePage}?id=${item.id}&item=${item.toString()}');
    // return showModalBottomSheet<int>(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: 700,
    //       color: Colors.grey,
    //       child: Scaffold(
    //         resizeToAvoidBottomInset: true,
    //         body: AddNote(orderId: item.id!,  item: item.toString()),     //AddNote should be your Widget that will be displayed inside the bottomSheet
    //       ),
    //     );
    //   },
    // );
  }

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
          slivers: _logList.isNotEmpty
              ? _buildGroups()
              : [
                  const SliverFillRemaining(
                      child: Center(child: Text('search by phone or log')))
                ],
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
      String date = DateFormat('MMM d', 'en_US').format(createdAt);
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
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(date,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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

  Widget _buildItem(CollectionLog2Data log) {
    final TextStyle? textTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: Dimens.font_sp12);
    return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 18, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: textTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: DateFormat('hh:mm a', 'en_US').format(
                                    DateTime.parse(log.createdAt!)
                                        .toUtc()
                                        .add(const Duration(hours: 1))),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (log.gType == 2)
                  Text(
                      'Pay by ${DateFormat("MMM dd 'at' HH:mm").format(DateTime.parse(log.kPromiseTime!))}',
                      style: TextStyle(
                          fontSize: 10, color: _colorList[log.gType!]))
                else
                  Gaps.empty,
                Gaps.hGap4,
                InkWell(
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: log.aAAAAABLCollectionOrder!.tBorrowSn),
                          ],
                        ),
                      ),
                      Gaps.hGap2,
                      Icon(
                        Icons.content_copy,
                        size: 14,
                        color: Colours.app_main.withOpacity(0.6),
                      ),
                      Gaps.hGap4,
                    ],
                  ),
                  onTap: () {
                    FlutterClipboard.copy(
                        log.aAAAAABLCollectionOrder!.tBorrowSn!);
                  },
                ),
                InkWell(
                  onTap: () {
                    _showModalBottomSheet(log.aAAAAABLCollectionOrder!);
                  },
                  child: Row(
                    children: [
                      Gaps.hGap4,
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: (DateTime.parse(log
                                                .aAAAAABLCollectionOrder!
                                                .sFlowOutTime!)
                                            .difference(DateTime.now())
                                            .inHours >=
                                        24)
                                    ? DateTime.parse(log
                                                .aAAAAABLCollectionOrder!
                                                .sFlowOutTime!)
                                            .difference(DateTime.now())
                                            .inDays
                                            .toString() +
                                        'd left'
                                    : DateTime.parse(log
                                                .aAAAAABLCollectionOrder!
                                                .sFlowOutTime!)
                                            .difference(DateTime.now())
                                            .inHours
                                            .toString() +
                                        'h left'),
                          ],
                        ),
                      ),
                      Gaps.hGap2,
                      Icon(
                        Icons.edit,
                        size: 14,
                        color: Colours.app_main.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gaps.vGap4,
            Text(log.jContent!),
          ],
        ));
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SliverAppBarDelegate(this.child, this.height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
