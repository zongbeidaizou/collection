import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../iview/order_list_page_iview.dart';


class OrderListPagePresenter extends BasePagePresenter<OrderListPageIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await product(false);
      await admins(false);
      view.onRefresh();
    });
  }

  Future<List<CollectionOrderData>> index(int page, int status, bool isShowDialog) async {


    List<CollectionOrderData> _list = <CollectionOrderData>[];
    FormData formData = FormData.fromMap({"page": page, 'k_status': status});
    await requestNetwork<CollectionOrderEntity>(Method.get, url: HttpApi.collectionOrders, queryParameters: {"page": page, 'k_status': status}, onSuccess: (data) async {
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

  Future<void> product( bool isShowDialog) async {
    await requestNetwork<ProductEntity>(Method.get, url: HttpApi.product, queryParameters: {"page": 1}, onSuccess: (data) async {
      if (data != null) {
        view.setProduct(data.data!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }
  Future<void> admins( bool isShowDialog) async {
    await requestNetwork<AdminEntity>(Method.get, url: HttpApi.admins, queryParameters: {"page": 1}, onSuccess: (data) async {
      if (data != null) {
        view.setAdmin(data.data!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }
 
}
