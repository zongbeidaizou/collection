import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';
import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';

import '../../models/admin_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';

abstract class SmsHistoryPageMvpView implements IMvpView {
  void onRefresh();
  void setList(List<HKContactSmsData> list);

}
