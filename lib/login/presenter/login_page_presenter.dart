import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/util/device_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/authoriz_store_entity.dart';
import '../../res/constant.dart';
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
    // 获取设备信息
    final Map<String, dynamic> deviceInfo = await Device.getDeviceInfo();
    
    Map<String, dynamic> loginInfo = {
      'grant_type': 'password',
      'client_id': '5',
      'client_secret': 'ANjjcoUpN74KnNSJlX7Rg58IwCF2keVsf4WluF4D',
      'scope': '*',
      'username': phone,
      'password': password,
    };
    
    // 将设备信息添加到登录参数中
    loginInfo.addAll(deviceInfo);

    FormData formData = FormData.fromMap(loginInfo);
    requestNetwork<AuthorizStoreEntity>(Method.post, url: HttpApi.authorizations, params: formData, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {
        SpUtil.putString(Constant.accessToken, data.passport!.accessToken!);
        SpUtil.putString(Constant.refreshToken, data.passport!.refreshToken!);
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
