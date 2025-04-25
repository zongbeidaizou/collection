import 'package:flutter/material.dart';

import '../models/collection_order_entity.dart';


class RefreshProvider extends ChangeNotifier {

  bool _orderRefresh = false;
  bool get orderRefresh => _orderRefresh;
  bool _logRefresh = false;
  bool get logRefresh => _logRefresh;
  bool _bonusRefresh = false;
  bool get bonusRefresh => _bonusRefresh;
  int _bonusNewCount = 0;
  int get bonusNewCount => _bonusNewCount;
  bool _newsRefresh = false;
  bool get newsRefresh => _newsRefresh;
  bool _homeRefresh = false;
  bool get homeRefresh => _homeRefresh;

  void setUserEntity(CollectionOrderOther userEntity) {
    if(userEntity.profile!.aGCollectionCommissionNewCount != _bonusNewCount){
      _bonusNewCount = userEntity.profile!.aGCollectionCommissionNewCount!;
      _bonusRefresh = true;
      notifyListeners();
    }
  }
  void setBonusRefresh(bool newValue) {
    _bonusRefresh = newValue;
    notifyListeners();
  }


}

