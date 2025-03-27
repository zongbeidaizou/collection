import 'package:bounty_hunter/generated/json/collection_order_entity.g.dart';
import 'package:flutter/material.dart';

import '../models/collection_order_entity.dart';


class OrderListProvider extends ChangeNotifier {
  List<CollectionOrderData> _list = <CollectionOrderData>[];

  List<CollectionOrderData> get list => _list;

  void changeList(CollectionOrderData order) {
    final int index = _list.indexWhere((item) => item.id == order.id);
    if (index != -1) {
      _list.removeAt(index);
      _list.add(order);
      notifyListeners();
    }
    // _list = _list.map((item) {
    //   if (item.id == order.id) {
    //     return item.copyWith(kStatus: order.kStatus,aDLastLogTime: order.aDLastLogTime,aLLastLog: order.aLLastLog,aNCurrentDayLogCount: order.aNCurrentDayLogCount,aOCurrentDayCallCount: order.aOCurrentDayCallCount); // 使用copyWith方法复制并修改状态
    //   }
    //   return item;
    // }).toList();
    // notifyListeners();
  }
  void setList(List<CollectionOrderData> list) {
    _list = list;
    notifyListeners();
  }


}
