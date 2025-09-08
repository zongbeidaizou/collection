import 'package:bounty_hunter/models/shop_entity.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/mvp/power_presenter.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/order/presenter/order_search_presenter.dart';
import 'package:bounty_hunter/order/provider/base_list_provider.dart';
import 'package:bounty_hunter/shop/iview/shop_iview.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';
import 'package:bounty_hunter/shop/presenter/shop_presenter.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/widgets/my_refresh_list.dart';
import 'package:bounty_hunter/widgets/my_search_bar.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'order_list_page.dart';
import 'order_search_result_page.dart';

/// design/3订单/index.html#artboard8
class OrderSearchPage extends StatefulWidget {
  const OrderSearchPage({super.key});

  @override
  _OrderSearchPageState createState() => _OrderSearchPageState();
}

class _OrderSearchPageState extends State<OrderSearchPage> {
  @override
  BaseListProvider<SearchItems> provider = BaseListProvider<SearchItems>();

  String _keyword = '';
  int _page = 1;

  @override
  void initState() {
    /// 默认为加载中状态，本页面场景默认为空
    provider.stateType = StateType.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySearchBar(
        hintText: 'phone or contact phone',
        onPressed: (text) {
          if (text.isEmpty) {
            showToast('Search keyword cannot be empty！');
            return;
          }
          setState(() {
            _keyword = text;
          });
          // provider.setStateType(StateType.loading);
          _page = 1;
          // _orderSearchPresenter.search(_keyword, _page, true);
        },
      ),
      body: OrderSearchResultPage(
        key: ValueKey(_keyword),
        index: 1,
        keyword: _keyword,
      ),
    );
  }

  Future<void> _onRefresh() async {
    _page = 1;
    await _orderSearchPresenter.search(_keyword, _page, false);
  }

  Future<void> _loadMore() async {
    _page++;
    await _orderSearchPresenter.search(_keyword, _page, false);
  }

  late OrderSearchPresenter _orderSearchPresenter;
  late ShopPagePresenter _shopPagePresenter;
}
