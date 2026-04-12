import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_log2_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_notification_entity.dart';
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';

abstract class MarketingPageMvpView implements IMvpView {
  void onRefresh();
  void setLogs(List<MarketingData> logs, {bool clear = false});
  void setTemplates(
      List<MarketingOtherTemplates2> templates, String url, String appName);
  void setTips(List<String> tips);
  void setPageSize(int pageSize);
  void setCurrentPage(int currentPage);
}
