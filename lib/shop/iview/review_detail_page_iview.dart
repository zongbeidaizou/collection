import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log2_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_notification_entity.dart';
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';

abstract class ReviewDetailPageMvpView implements IMvpView {
  void setResult(bool result);
  void setLogs(List<SGContactData> logs, {bool clear = false});
  void setPageSize(int pageSize);
  void setCurrentPage(int currentPage);
}
