import 'package:bounty_hunter/order/presenter/order_list_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/provider/order_page_provider.dart';
import 'package:bounty_hunter/order/widgets/order_item.dart';
import 'package:bounty_hunter/order/widgets/order_tag_item.dart';
import 'package:bounty_hunter/util/change_notifier_manage.dart';
import 'package:bounty_hunter/widgets/my_refresh_list.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../mvp/base_page.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/user_provider.dart';
import '../iview/order_list_page_iview.dart';
const List<List<int>> indexMap = [[0], [1], [2], [3], [4,5]];

class OrderListPage extends StatefulWidget {

  const OrderListPage({
    super.key,
    required this.index,
  });

  final int index;
  
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with AutomaticKeepAliveClientMixin<OrderListPage>, ChangeNotifierMixin<OrderListPage>, BasePageMixin<OrderListPage, OrderListPagePresenter>
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
    return VisibilityDetector(
      key: Key('order_page${widget.index}'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        // if(visiblePercentage >10 ){
        //   final updateAt = DateTime.parse(context.read<UserProvider>().userEntity.profile!.updatedAt!);
        //   final now = DateTime.now().toUtc().add(const Duration(hours: 1));
        //   final difference = now.difference(updateAt);
        //   if(difference.inHours > 2){
        //     _onRefresh();
        //   }
        // }
      },
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            // _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 120.0, /// 默认40， 多添加的80为Header高度
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
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  child!,
                ],
              );
            },
            child: Consumer<OrderListProvider>(
                builder: (_, provider2, child) {
                return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: provider2.list.where((element) => indexMap[widget.index].contains(element.kStatus)).toList().isEmpty ? SliverFillRemaining(child: Center(child: Text("no data"))) :
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return index < provider2.list.where((element) => indexMap[widget.index].contains(element.kStatus)).toList().length ?
                  OrderItem(
                    key: Key('order_item_$index'),
                    index: index,
                    tabIndex: _index,
                    item: provider2.list.where((element) => indexMap[widget.index].contains(element.kStatus)).toList()[index],
                    products: _product,
                    admins: _admins,
                    repayInfo: CollectionLogOtherRepayInfo(),
                    track: CollectionLogOtherTrack(),
                    period: CollectionLogOtherPeriod(),
                    contactList: [],
                    smsHistory: [],
                  ) :
                  MoreWidget(provider2.list.where((element) => indexMap[widget.index].contains(element.kStatus)).toList().length, _hasMore(), 10);

                },
                childCount: provider2.list.where((element) => indexMap[widget.index].contains(element.kStatus)).toList().length + 1),
              ));
            }),
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
      _page ++;
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
