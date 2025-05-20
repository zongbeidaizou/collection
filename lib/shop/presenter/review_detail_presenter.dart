import 'dart:convert';

import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/shop/iview/review_detail_page_iview.dart';
import 'package:bounty_hunter/shop/iview/review_page_iview.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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

class ReviewDetailPresenter extends BasePagePresenter<ReviewDetailPageMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      view.onRefresh();
    });
  }

  Future<void> index(int borrowId, bool isShowDialog,
      {String keyword = ''}) async {
    List<SGContactData> _list = <SGContactData>[];
    SGContactEntity _data = SGContactEntity();
    //这个地方如果写isShow=true会报错'package:flutter/src/widgets/navigator.dart': Failed assertion: line 5350 po
    await requestNetwork<SGContactEntity>(Method.get,
        url: HttpApi.contactlist,
        queryParameters: {"borrow_id": borrowId, 'keyword': keyword},
        isShow: isShowDialog, onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      view.getContext().read<RefreshProvider>().setUserEntity(data.other!);
      if (data != null) {
        _list = data.data!;
        _data = data;
        view.setLogs(_list);
        view.getContext().read<UserProvider>().setUserEntity(data.other!);
        view.getContext().read<RefreshProvider>().setUserEntity(data.other!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  
}
