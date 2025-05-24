import 'dart:convert';

import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/iview/sms_history_page_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/order_list_page_iview.dart';


class SmsHistoryPresenter extends BasePagePresenter<SmsHistoryPageMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      view.onRefresh();
    });
  }

  Future<void> index(int borrowId, int page,  bool isShowDialog, {String keyword = ''}) async {

    final String? cacheData = await Cache().checkCache('sms_history_$borrowId');
    if (cacheData == null) {
    await requestNetwork<HKContactSmsEntity>(Method.get, url: HttpApi.smsHistory, queryParameters: {'page': page, 'borrow_id': borrowId}, onSuccess: (data) async {
      if (data != null) {
        Cache().cacheData('sms_history_$borrowId', data.toString(), 3600);
        view.setList(data.data!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    }else{
      view.setList(HKContactSmsEntity.fromJson(jsonDecode(cacheData) as Map<String, dynamic >).data!);
    }



  }


  

 
}
