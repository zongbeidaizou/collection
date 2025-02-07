import 'package:bounty_hunter/mvp/mvps.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';

abstract class ShopIMvpView implements IMvpView {

  void setUser(UserEntity? user);
  
  bool get isAccessibilityTest;
}
