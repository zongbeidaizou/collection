import 'package:bounty_hunter/order/widgets/add_note.dart';
import 'package:fluro/fluro.dart';
import 'package:bounty_hunter/routers/i_router.dart';

import 'page/order_info_page.dart';
import 'page/order_page.dart';
import 'page/order_search_page.dart';
import 'page/order_receive_page.dart';
import 'page/order_track_page.dart';

class OrderRouter implements IRouterProvider{

  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderReceivePage = '/order/receive';
  static String orderTrackPage = '/order/track';
  static String notePage = '/order/note';

  @override
  void initRouter(FluroRouter router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => const OrderPage()));
    router.define(notePage, handler: Handler(handlerFunc: (_, params) {
      print(params['id']);
      print(params['item']);
      final String id = params['id']!.first;
      final String item = params['item']!.first;
      return AddNote(
        orderId: int.parse(id),
        item: item,
      );
    }));

    // router.define(orderInfoPage, handler: Handler(handlerFunc: (_, __) => const OrderInfoPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, params) {
      print(params['id']);
      print(params['track']);
      print(params['period']);
      final String id = params['id']!.first;
      final String track = params['track']!.first;
      final String period = params['period']!.first;
      return OrderInfoPage(
        orderId: int.parse(id),
        track: track,
        period: period,
      );
    }));
    router.define(orderSearchPage, handler: Handler(handlerFunc: (_, __) => const OrderSearchPage()));
    router.define(orderReceivePage, handler: Handler(handlerFunc: (_, __) => const OrderReceivePage()));
    router.define(orderTrackPage, handler: Handler(handlerFunc: (_, __) => const OrderTrackPage()));
  }
  
}
