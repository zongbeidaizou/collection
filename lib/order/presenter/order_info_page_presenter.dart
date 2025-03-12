import 'dart:convert';

import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/order_info_page_iview.dart';
import '../iview/order_list_page_iview.dart';


class OrderInfoPagePresenter extends BasePagePresenter<OrderInfoPageIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  Future<bool> deduction(Map<String, dynamic> loginInfo, bool isShowDialog) async {

    FormData formData = FormData.fromMap(loginInfo);
    requestNetwork<AuthorizStoreEntity>(Method.post, url: HttpApi.deduction, params: formData, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return true;
  }



 
}
