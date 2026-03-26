import 'dart:async';

import 'package:bounty_hunter/order/presenter/order_list_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bounty_hunter/util/change_notifier_manage.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../mvp/base_page.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/user_provider.dart';
import 'package:bounty_hunter/order/widgets/order_item.dart';
import '../iview/order_list_page_iview.dart';

const List<List<int>> indexMap = [
  [0],
  [1],
  [2],
  [3],
  [4, 5]
];

class OrderReceiveResultPage extends StatefulWidget {
  const OrderReceiveResultPage({
    super.key,
    required this.index,
    required this.keyword,
  });

  final int index;
  final String keyword;

  @override
  _OrderReceiveResultPageState createState() => _OrderReceiveResultPageState();
}

class _OrderReceiveResultPageState extends State<OrderReceiveResultPage>
    with
        AutomaticKeepAliveClientMixin<OrderReceiveResultPage>,
        ChangeNotifierMixin<OrderReceiveResultPage>,
        BasePageMixin<OrderReceiveResultPage, OrderListPagePresenter>
    implements OrderListPageIMvpView {
  final ScrollController _controller = ScrollController();
  int _index = 0;
  List<CollectionOrderData> _list = <CollectionOrderData>[];
  List<ProductData> _product = <ProductData>[];
  List<AdminData> _admins = <AdminData>[];
  late OrderListPagePresenter _orderListPagePresenter;
  OrderListProvider provider2 = OrderListProvider();
  final ScrollController _scrollController = ScrollController();
  static const String _kReceiveResultLastIndexTimeKey =
      'order_receive_result_last_index_time';
  bool _isCheckingStaleRefresh = false;
  Timer? _staleCheckTimer;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    // Prevent soft keyboard from popping up when this page opens.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FocusScope.of(context).unfocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _maybeForceRefreshIfStale();
    });
    _staleCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _maybeForceRefreshIfStale();
    });
    // _onRefresh();
  }

  Future<void> _maybeForceRefreshIfStale() async {
    if (_isCheckingStaleRefresh) return;
       //如果当前时间为凌晨1点到5点，则不进行刷新
    final now = DateTime.now();
    if (now.hour >= 1 && now.hour <= 5) {
      return;
    }
    _isCheckingStaleRefresh = true;
    final String? lastRequestAt = await Cache().getString(_kReceiveResultLastIndexTimeKey);
    if (!mounted) {
      _isCheckingStaleRefresh = false;
      return;
    }
    try {
      if (lastRequestAt == null || lastRequestAt.isEmpty) {
        await _onRefresh();
        return;
      }
      final DateTime? lastTime = DateTime.tryParse(lastRequestAt);
      if (lastTime == null ||
          DateTime.now().difference(lastTime) >= const Duration(hours: 1)) {
        await _onRefresh();
      }
    } finally {
      _isCheckingStaleRefresh = false;
    }
  }

  @override
  void dispose() {
    _staleCheckTimer?.cancel();
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
    final int receiveLeftCnt = context.select<UserProvider, int>(
        (p) => p.userEntity.profile?.cQWeekReceiveLeftCnt ?? 0);
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
        child: _list.isNotEmpty
            ? ListView.builder(
                itemCount: _list.length + 1,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 28.0),
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        'Receivable cases left this week: $receiveLeftCnt',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                  final item = _list[index - 1];
                  return OrderItem(
                    key: Key('order_item_${item.id}'),
                    index: index - 1,
                    showContactDays: 0,
                    tabIndex: _index,
                    item: item,
                    products: _product,
                    admins: _admins,
                    repayInfo: CollectionLogOtherRepayInfo(),
                    couponList: const <CollectionLogOtherCouponList>[],
                    track: CollectionLogOtherTrack(),
                    period:
                        item.aAAAAQBPeriods ?? CollectionLogOtherPeriod(),
                    contactList: <CollectionLogOtherContactInfo2Data>[],
                    smsHistory: <CollectionLogOtherSmsHistory>[],
                    allContactList: <CollectionLogOtherContactInfo2Data>[],
                    source: 'receive',
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Receivable cases left this week: $receiveLeftCnt',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                        'Receive by phone or contact phone or borrower name (Online)'),
                        if(widget.keyword.isNotEmpty && _list.isEmpty)
                    Text('No data found by the keyword: ${widget.keyword}',style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.red),),
                  ],
                ),
              ),
      ),
    );
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
    String keyword = widget.keyword.isNotEmpty ? widget.keyword : 'random';
    _list = await _orderListPagePresenter.index(1, widget.index, true,
        keyword2: keyword);
    await Cache().setString(
      _kReceiveResultLastIndexTimeKey,
      DateTime.now().toIso8601String(),
    );
    setState(() {
      // refresh list
    });
  }

  @override
  void setList(List<CollectionOrderData> list) {
    setState(() {
      _list = list;
    });
  }
}
