import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/authoriz_store_entity.dart';
import '../iview/login_page_iview.dart';


class LoginPagePresenter extends BasePagePresenter<LoginPageIviewIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    });
  }

  void login(String phone, String password,  bool isShowDialog) async {

/*    Map<String, dynamic> loginInfo = {
      "username": phone,
      "password": password,
      "autoLogin": true
    };*/
    Map<String, dynamic> loginInfo = {
      'grant_type': 'password',
      'client_id': '5',
      'client_secret': 'ANjjcoUpN74KnNSJlX7Rg58IwCF2keVsf4WluF4D',
      'scope': '*',
      'username': phone,
      'password': password,

    };

    FormData formData = FormData.fromMap(loginInfo);
    requestNetwork<AuthorizStoreEntity>(Method.post, url: HttpApi.authorizations, params: formData, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {

        view.loginSuccess();
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }
 
}
