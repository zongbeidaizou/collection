import 'dart:convert';

import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/shop/iview/marketing_page_iview.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/b_f_review_borrow_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/message_page_iview.dart';

class MarketingPresenter extends BasePagePresenter<MarketingPageMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  Future<void> index(int currentPage, bool isShowDialog,
      {String keyword = ''}) async {
    final List<String>? marketingDetailLogs =
        SpUtil.getStringList('marketing_detail_logs');

    // 检查是否有需要提交的数据
    bool hasDataToSubmit = (marketingDetailLogs?.isNotEmpty ?? false);
    if (hasDataToSubmit) {
      // 将列表用逗号拼接成字符串
      String? marketingDetailLogsStr = marketingDetailLogs?.join(',');
      final formData2 = FormData.fromMap({
        if (marketingDetailLogsStr != null)
          'action_str': marketingDetailLogsStr,
      });
      requestNetwork<CollectionOrderEntity>(Method.post,
          url: HttpApi.marketingStore,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('marketing_detail_logs');
      }, onError: (_, __) async {});
    }

    List<MarketingData> _list = <MarketingData>[];
    MarketingEntity _data = MarketingEntity();
    await requestNetwork<MarketingEntity>(Method.get,
        url: HttpApi.marketing,
        queryParameters: {"page": currentPage, 'keyword': keyword},
        isShow: isShowDialog, onSuccess: (data) async {
      if (data != null) {
        _list = data.data!;
        view.setLogs(_list);
        _data = data;
        view.setPageSize((data.total! / data.perPage!).ceil());
        view.setCurrentPage(data.currentPage!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  Future<void> markAsRead(bool isShowDialog, {String keyword = ''}) async {
    Map<String, dynamic> loginInfo = {
      'grant_type': 'password',
    };
    FormData formData = FormData.fromMap(loginInfo);
    List<MarketingData> _list = <MarketingData>[];
    await requestNetwork<MarketingEntity>(Method.put,
        url: '${HttpApi.notification}/1',
        params: formData,
        isShow: isShowDialog, onSuccess: (data) async {
      if (data != null) {
        _list = data.data!;
        view.setLogs(_list, clear: true);
        view.setPageSize((data.total! / data.perPage!).ceil());
        view.setCurrentPage(data.currentPage!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }
}
