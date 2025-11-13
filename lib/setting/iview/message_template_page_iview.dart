import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/mvp/mvps.dart';

abstract class MessageTemplatePageMvpView implements IMvpView {
  void onRefresh();
  void setData(List<MarketingData> logs, {bool clear = false});
  void setTemplates(List<String> templates, String url);
  void setPageSize(int pageSize);
  void setCurrentPage(int currentPage);
}
