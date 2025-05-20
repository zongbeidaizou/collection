import 'package:bounty_hunter/shop/page/all_hall_page.dart';
import 'package:bounty_hunter/shop/page/review_detail_page.dart';
import 'package:bounty_hunter/shop/page/review_page.dart';
import 'package:fluro/fluro.dart';
import 'package:bounty_hunter/routers/i_router.dart';

import 'page/freight_config_page.dart';
import 'page/input_text_page.dart';
import 'page/message_page.dart';
import 'page/select_address_page.dart';
import 'page/shop_page.dart';
import 'page/shop_setting_page.dart';

class ShopRouter implements IRouterProvider{

  static String shopPage = '/shop';
  static String shopSettingPage = '/shop/shopSetting';
  static String messagePage = '/shop/message';
  static String reviewPage = '/shop/review';
  static String reviewDetailPage = '/shop/reviewDetail';
  static String allHallPage = '/shop/allHall';
  static String freightConfigPage = '/shop/freightConfig';
  static String addressSelectPage = '/shop/addressSelect';
  static String inputTextPage = '/shop/inputText';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, __) => const ShopPage()));
    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, __) => const ShopSettingPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, __) => const MessagePage()));
    router.define(reviewPage, handler: Handler(handlerFunc: (_, __) => const ReviewPage()));
    router.define(reviewDetailPage, handler: Handler(handlerFunc: (_, params) {
      print(params['id']);
      print(params['item']);
      final String borrowId = params['borrowId']!.first;
      final String name = params['name']!.first;
      return ReviewDetailPage(
        borrowId: int.parse(borrowId),
        name: name,
      );
    }));
    router.define(allHallPage, handler: Handler(handlerFunc: (_, __) => const AllHallPage()));
    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, __) => const FreightConfigPage()));
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_, __) => const AddressSelectPage()));
    router.define(inputTextPage, handler: Handler(handlerFunc: (context, params) {
      /// 类参数
      final args = context!.settings!.arguments! as InputTextPageArgumentsData;
      return InputTextPage(
        title: args.title,
        hintText: args.hintText,
        content: args.content,
        keyboardType: args.keyboardType,
      );
    }));
  }
}
