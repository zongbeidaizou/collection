import 'package:bounty_hunter/generated/json/collection_order_entity.g.dart';
import 'package:flutter/material.dart';

import '../models/collection_order_entity.dart';


class OrderListProvider extends ChangeNotifier {
  List<CollectionOrderData> _list = <CollectionOrderData>[];

  List<CollectionOrderData> get list => _list;

  void changeList(CollectionOrderData order) {
    _list = _list.map((item) {
      if (item.id == order.id) {
        return item.copyWith(kStatus: order.kStatus); // 使用copyWith方法复制并修改状态
      }
      return item;
    }).toList();
    notifyListeners();
  }
  void setList(List<CollectionOrderData> list) {
    _list = list;
    notifyListeners();
  }


}
