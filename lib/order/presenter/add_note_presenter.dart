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
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/add_note_iview.dart';
import '../iview/order_list_page_iview.dart';


class AddNotePresenter extends BasePagePresenter<AddNoteIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      view.onRefresh();
      await product(false);
      await admins(false);
    });
  }

  Future<CollectionLogEntity> index(int page, int orderId, bool isShowDialog) async {


    List<CollectionLogData> _list = <CollectionLogData>[];
    CollectionLogEntity _data = CollectionLogEntity() ;
    FormData formData = FormData.fromMap({"page": page, 'p_collection_order_id': orderId});
    await requestNetwork<CollectionLogEntity>(Method.get, url: HttpApi.collectionLogs, queryParameters: {"page": page, 'p_collection_order_id': orderId}, onSuccess: (data) async {
      if (data != null) {
        _list =  data.data!;
        _data = data;

      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return _data;
  }
  Future<void> store(Map<String, dynamic> data, bool isShowDialog) async {
    FormData formData = FormData.fromMap(data);
    await requestNetwork<CollectionOrderEntity>(Method.post, url: HttpApi.collectionLogs, params: formData,  onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      var a = data.data!.first;
      view.getContext().read<OrderListProvider>().changeList(data.data!.first);
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
      }
    });
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


 
}
