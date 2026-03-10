import 'package:bounty_hunter/order/presenter/order_list_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/provider/order_page_provider.dart';
import 'package:bounty_hunter/order/widgets/order_item.dart';
import 'package:bounty_hunter/order/widgets/order_tag_item.dart';
import 'package:bounty_hunter/util/change_notifier_manage.dart';
import 'package:bounty_hunter/widgets/my_refresh_list.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../mvp/base_page.dart';
import '../../providers/order_list_provider.dart';
import '../iview/order_list_page_iview.dart';

const List<List<int>> indexMap = [
  [0],
  [1],
  [2],
  [3],
  [4, 5]
];

class OrderSearchResultPage extends StatefulWidget {
  const OrderSearchResultPage({
    super.key,
    required this.index,
    required this.keyword,
  });

  final int index;
  final String keyword;

  @override
  _OrderSearchResultPageState createState() => _OrderSearchResultPageState();
}

class _OrderSearchResultPageState extends State<OrderSearchResultPage>
    with
        AutomaticKeepAliveClientMixin<OrderSearchResultPage>,
        ChangeNotifierMixin<OrderSearchResultPage>,
        BasePageMixin<OrderSearchResultPage, OrderListPagePresenter>
    implements OrderListPageIMvpView {
  final ScrollController _controller = ScrollController();
  final StateType _stateType = StateType.loading;

  /// 是否正在加载数据
  bool _isLoading = false;
  final int _maxPage = 3;
  int _page = 1;
  int _index = 0;
  List<CollectionOrderData> _list = <CollectionOrderData>[];
  List<CollectionOrderData> _listNew = <CollectionOrderData>[];
  List<ProductData> _product = <ProductData>[];
  List<AdminData> _admins = <AdminData>[];
  late OrderListPagePresenter _orderListPagePresenter;
  OrderListProvider provider2 = OrderListProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    // _onRefresh();
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
        child: _list.isNotEmpty
            ? ListView.builder(
                itemCount: _list.length,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 28.0),
                itemBuilder: (_, index) => OrderItem(
                  key: Key('order_item_$index'),
                  index: index,
                  showContactDays: 0,
                  tabIndex: _index,
                  item: _list[index],
                  products: _product,
                  admins: _admins,
                  repayInfo: CollectionLogOtherRepayInfo(),
                  couponList: const [],
                  track: CollectionLogOtherTrack(),
                  period: CollectionLogOtherPeriod(),
                  contactList: [],
                  smsHistory: [],
                  allContactList: [],
                ),
              )
            : Center(
                child:
                    Text('Search by phone or contact phone or borrower name ')),
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
    String keyword = widget.keyword.isNotEmpty ? widget.keyword : 'JJJJJJJJJJJ';
    _list = await _orderListPagePresenter.index(1, widget.index, true,
        keyword: keyword);
    setState(() {
      _page = 1;
    });
  }

  @override
  void setList(List<CollectionOrderData> list) {
    setState(() {
      _list = list;
    });
  }
}
