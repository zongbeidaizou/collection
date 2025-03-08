import 'dart:convert';

import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../util/cache.dart';
import '../iview/goods_list_iview.dart';


class GoodsListPresenter extends BasePagePresenter<GoodsListMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await product(false);
      await admins(false);
    });
  }

  Future<void> index(int currentPage, int type, bool isShowDialog) async {
    List<CollectionLog2Data> _list = <CollectionLog2Data>[];
    CollectionLog2Entity _data = CollectionLog2Entity() ;
    await requestNetwork<CollectionLog2Entity>(Method.get, url: HttpApi.collectionLogs2, queryParameters:{"page": currentPage, 'g_type': type}, onSuccess: (data) async {
      if (data != null) {
        _list =  data.data!;
        _data = data;
        view.setLogs(_list);
        view.setPageSize(4);
        view.setCurrentPage(data.currentPage!);

      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  Future<void> product( bool isShowDialog) async {
    String? productString = await Cache().checkCache('products');
    if (productString == null) {
      await requestNetwork<ProductEntity>(Method.get, url: HttpApi.product, queryParameters: {"page": 1}, onSuccess: (data) async {
        if (data != null) {
          view.setProduct(data.data!);
          Cache().cacheData('products', data.toString(), 60);
        }
      }, onError: (_, __) async {
        if (_ == 200006) {
        } else {
          view.showToast(__);
        }
      });
    }else{
      view.setProduct(ProductEntity.fromJson(jsonDecode(productString) as Map<String, dynamic >).data!);
    }
  }

  Future<void> admins( bool isShowDialog) async {
    String? productString = await Cache().checkCache('admins');
    if (productString == null) {
      await requestNetwork<AdminEntity>(Method.get, url: HttpApi.admins, queryParameters: {"page": 1}, onSuccess: (data) async {
        if (data != null) {
          view.setAdmin(data.data!);
          Cache().cacheData('admins', data.toString(), 60);
        }
      }, onError: (_, __) async {
        if (_ == 200006) {
        } else {
          view.showToast(__);
        }
      });
    }else{
      view.setAdmin(AdminEntity.fromJson(jsonDecode(productString) as Map<String, dynamic >).data!);
    }
  }

}
