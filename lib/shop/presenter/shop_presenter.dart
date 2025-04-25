import 'package:flutter/material.dart';
import 'package:bounty_hunter/account/models/city_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/shop/iview/shop_iview.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';
import 'package:provider/provider.dart';

import '../../models/shop_entity.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';


class ShopPagePresenter extends BasePagePresenter<ShopIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // if (view.isAccessibilityTest) {
      //   return;
      // }
      await show(true);
      
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
      // asyncRequestNetwork<UserEntity>(Method.get,
      //   url: HttpApi.users,
      //   onSuccess: (data) {
      //     view.setUser(data);
      //   },
      // );
    });

}
  Future<void> show(bool isShowDialog) async {
    await requestNetwork<ShopEntity>(Method.get, url: '${HttpApi.shop}/1', queryParameters: {"page": 1}, onSuccess: (data) async {
      view.setData(data!.data!);
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      view.getContext().read<RefreshProvider>().setUserEntity(data!.other!);
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }
 
  void testListData() {
    /// 测试返回List类型数据解析
    asyncRequestNetwork<List<CityEntity>>(Method.get,
      url: HttpApi.subscriptions,
      onSuccess: (data) {

      },
    );
  }
}
