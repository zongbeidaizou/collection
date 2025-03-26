import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/admin_entity.dart';
import '../../models/product_entity.dart';

abstract class OrderPageIMvpView implements IMvpView {
  void onRefresh();
  void setProduct(List<ProductData> product);
  void setAdmin(List<AdminData> admins);
/*  void onRefresh();
  bool hasMore();
  void loadMore();*/
}
