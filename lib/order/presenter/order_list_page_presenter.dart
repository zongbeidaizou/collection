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
import '../../providers/order_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
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

  Future<List<CollectionOrderData>> index(int page, int status, bool isShowDialog, {String keyword = ''}) async {
    if (keyword == 'JJJJJJJJJJJ') {
      return [];
    }

    List<CollectionOrderData> _list = <CollectionOrderData>[];
    await requestNetwork<CollectionOrderEntity>(Method.get, url: HttpApi.collectionOrders, queryParameters: {'page': page, 'keyword': keyword}, onSuccess: (data) async {
      if (data != null) {
        _list =  data.data!;
        view.getContext().read<OrderListProvider>().setList(data.data!);
        // view.setList(data.data!);
      }
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return _list;
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

  Future<void> product( bool isShowDialog) async {
    String? productString = await Cache().checkCache('products');
    if (productString == null) {
      await requestNetwork<ProductEntity>(Method.get, url: HttpApi.product, queryParameters: {"page": 1}, onSuccess: (data) async {
        if (data != null) {
          view.setProduct(data.data!);
          Cache().cacheData('products', data.toString(), 3600);
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
          Cache().cacheData('admins', data.toString(), 3600);
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

  Future<void> profile( bool isShowDialog) async {
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
