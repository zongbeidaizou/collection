import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/json/collection_log_entity.dart';
import '../../models/product_entity.dart';

abstract class AddNoteIMvpView implements IMvpView {
  void onRefresh();
  void setLogs(List<CollectionLogData> logs);
/*  void onRefresh();
  bool hasMore();
  void loadMore();*/
}
