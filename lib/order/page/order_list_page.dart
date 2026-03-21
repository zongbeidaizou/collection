import 'dart:async';

import 'package:bounty_hunter/order/presenter/order_list_page_presenter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/provider/order_page_provider.dart';
import 'package:bounty_hunter/order/widgets/order_item.dart';
import 'package:bounty_hunter/util/change_notifier_manage.dart';
import 'package:bounty_hunter/widgets/my_refresh_list.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../mvp/base_page.dart';
import '../../providers/order_list_provider.dart';
import '../../util/cache.dart';
import '../iview/order_list_page_iview.dart';

const List<List<int>> indexMap = [
  [0],
  [1],
  [2],
  [3],
  [4, 5]
];

class OrderListPage extends StatefulWidget {
  const OrderListPage({
    super.key,
    required this.index,
    this.keyword = '',
  });

  final int index;
  final String keyword;

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with
        AutomaticKeepAliveClientMixin<OrderListPage>,
        ChangeNotifierMixin<OrderListPage>,
        BasePageMixin<OrderListPage, OrderListPagePresenter>
    implements OrderListPageIMvpView {
  final ScrollController _controller = ScrollController();
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _index = 0;
  List<CollectionOrderData> _list = <CollectionOrderData>[];
  List<CollectionOrderData> _listNew = <CollectionOrderData>[];
  List<ProductData> _product = <ProductData>[];
  List<AdminData> _admins = <AdminData>[];
  late OrderListPagePresenter _orderListPagePresenter;
  OrderListProvider provider2 = OrderListProvider();
  Timer? _autoRefreshTimer;
  Timer? _statisticsTimer;
  bool _isCheckingStaleRefresh = false;
  static const Duration _staleDuration = Duration(minutes: 30);

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    // _onRefresh();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _statisticsTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
        _orderListPagePresenter.statistics();
      });

      // Auto refresh check: periodically check if index API has not been called
      // in the last 30 minutes for this tab, and trigger a refresh if needed.
      _autoRefreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
        await _maybeForceRefreshIfStale();
      });

      // Also check immediately on first load
      await _maybeForceRefreshIfStale();
    });
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    _statisticsTimer?.cancel();
    super.dispose();
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    return {_controller: null};
  }

  @override
  bool get wantKeepAlive => true;

  @override
  OrderListPagePresenter createPresenter() {
    _orderListPagePresenter = OrderListPagePresenter();
    return _orderListPagePresenter;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          // _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0,

        /// 默认40， 多添加的80为Header高度
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  ///SliverAppBar的expandedHeight高度,避免重叠
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                child!,
              ],
            );
          },
          child: Consumer<OrderListProvider>(builder: (_, provider2, child) {
            final String keyword = widget.keyword.trim();
            final String keywordDigits = _normalizeDigits(keyword);

            bool matches(CollectionOrderData data) {
              if (keyword.isEmpty) return true;

              final phoneDigits = _normalizeDigits(data.uPhone ?? '');
              final name = (data.vName ?? '').toLowerCase();
              final kwLower = keyword.toLowerCase();

              // Fuzzy phone match: digits contains.
              if (keywordDigits.isNotEmpty &&
                  phoneDigits.contains(keywordDigits)) {
                return true;
              }

              // Fuzzy name match.
              return name.contains(kwLower);
            }

            final List<CollectionOrderData> tabList = provider2.list
                .where((element) => indexMap[widget.index].contains(element.kStatus))
                .toList();

            final List<CollectionOrderData> filteredList =
                keyword.isEmpty ? tabList : tabList.where(matches).toList();

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: filteredList.isEmpty
                  ? const SliverFillRemaining(child: Center(child: Text("no data")))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return index < filteredList.length
                              ? OrderItem(
                                  key: Key('order_item_$index'),
                                  index: index,
                                  tabIndex: _index,
                                  showContactDays: 0,
                                  item: filteredList[index],
                                  products: _product,
                                  admins: _admins,
                                  repayInfo: CollectionLogOtherRepayInfo(),
                                  couponList: const [],
                                  track: CollectionLogOtherTrack(),
                                  period: filteredList[index].aAAAAQBPeriods,
                                  contactList: [],
                                  allContactList: [],
                                  smsHistory: [],
                                )
                              : MoreWidget(filteredList.length, _hasMore(), 10);
                        },
                        childCount: filteredList.length + 1,
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }

  String _normalizeDigits(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  Future<void> _maybeForceRefreshIfStale() async {
    if (!mounted) return;
    if (_isCheckingStaleRefresh) return;
    if(widget.index != 0) return;
        final now = DateTime.now();
    if (now.hour >= 1 && now.hour <= 5) {
      return;
    }
    _isCheckingStaleRefresh = true;
    try {
      final String cacheKey = 'order_list_last_index_time';
      final String? lastIndexTime = await Cache().getString(cacheKey);
      if (!mounted) return;

      if (lastIndexTime == null || lastIndexTime.isEmpty) {
        await _onRefresh();
        return;
      }

      final DateTime? lastTime = DateTime.tryParse(lastIndexTime);
      if (lastTime == null ||
          DateTime.now().difference(lastTime) >= _staleDuration) {
            if (kDebugMode) {
              print('stale refresh: $_index');
              print('lastTime: $lastTime');
              print('DateTime.now().difference(lastTime!): ${DateTime.now().difference(lastTime!)}');
              print('staleDuration: $_staleDuration');
            }
        await _onRefresh();
      }
    } finally {
      _isCheckingStaleRefresh = false;
    }
  }

  @override
  void setProduct(List<ProductData> product) {
    setState(() {
      _product = product;
    });
  }

  @override
  void setAdmin(List<AdminData> admin) {
    setState(() {
      _admins = admin;
    });
  }

  @override
  void onRefresh() {
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    _list = await _orderListPagePresenter.index(1, widget.index, true);
    setState(() {
      _page = 1;
    });
  }

  bool _hasMore() {
    // return _page < _maxPage;
    return false;
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
      _page++;
    });
    _listNew = await _orderListPagePresenter.index(_page, widget.index, true);
    setState(() {
      _list.addAll(_listNew);
      _isLoading = false;
    });
  }

  @override
  void setList(List<CollectionOrderData> list) {
    // TODO: implement setList
  }
}
