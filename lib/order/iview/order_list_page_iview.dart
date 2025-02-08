import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

abstract class OrderListPageIMvpView implements IMvpView {
  void onRefresh();
/*  void onRefresh();
  bool hasMore();
  void loadMore();*/
}
