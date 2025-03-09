import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log2_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';

abstract class AccountRecordListMvpView implements IMvpView {
  void onRefresh();
  void setLogs(List<CommissionData> logs);
  void setPageSize(int pageSize);
  void setCurrentPage(int currentPage);
  void setProduct(List<ProductData> product);
  void setAdmin(List<AdminData> admins);

}
