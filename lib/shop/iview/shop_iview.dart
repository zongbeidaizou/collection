import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';

import '../../models/shop_entity.dart';

abstract class ShopIMvpView implements IMvpView {

  void setUser(UserEntity? user);
  void setData(ShopData data);
  
  bool get isAccessibilityTest;
}
