import 'dart:convert';

import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
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
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/message_page_iview.dart';


class MessagePresenter extends BasePagePresenter<MessagePageMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  Future<void> index(int currentPage, bool isShowDialog, {String keyword = ''}) async {
    List<CollectionNotificationData> _list = <CollectionNotificationData>[];
    CollectionNotificationEntity _data = CollectionNotificationEntity() ;
    //这个地方如果写isShow=true会报错'package:flutter/src/widgets/navigator.dart': Failed assertion: line 5350 po
    await requestNetwork<CollectionNotificationEntity>(Method.get, url: HttpApi.notification, queryParameters:{"page": currentPage,  'keyword': keyword}, isShow: isShowDialog, onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      if (data != null) {
        _list =  data.data!;
        _data = data;
        view.setLogs(_list);
        view.setPageSize((data.total!/data.perPage!).ceil());
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
