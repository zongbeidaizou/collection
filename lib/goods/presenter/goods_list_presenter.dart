import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/authoriz_store_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../iview/goods_list_iview.dart';


class GoodsListPresenter extends BasePagePresenter<GoodsListMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      index(1, 0, true);
    });
  }

  Future<void> index(int page, int orderId, bool isShowDialog) async {


    List<CollectionLog2Data> _list = <CollectionLog2Data>[];
    CollectionLog2Entity _data = CollectionLog2Entity() ;
    FormData formData = FormData.fromMap({"page": page, 'p_collection_order_id': orderId});
    await requestNetwork<CollectionLog2Entity>(Method.get, url: HttpApi.collectionLogs2, queryParameters: {"page": page, 'p_collection_order_id': orderId}, onSuccess: (data) async {
      if (data != null) {
        _list =  data.data!;
        _data = data;
        view.setLogs(_list);

      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }



 
}
