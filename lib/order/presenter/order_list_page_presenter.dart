import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/authoriz_store_entity.dart';
import '../../models/collection_order_entity.dart';
import '../iview/order_list_page_iview.dart';


class OrderListPagePresenter extends BasePagePresenter<OrderListPageIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      view.onRefresh();
    });
  }

  Future<List<CollectionOrderData>> index(int page,  bool isShowDialog) async {


    List<CollectionOrderData> _list = <CollectionOrderData>[];
    FormData formData = FormData.fromMap({"page": page});
    await requestNetwork<CollectionOrderEntity>(Method.get, url: HttpApi.collectionOrders, queryParameters: {"page": page}, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {
        _list =  data.data!;
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return _list;
  }
 
}
