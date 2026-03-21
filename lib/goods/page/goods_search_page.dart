
import 'package:flutter/material.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_search_bar.dart';

import 'goods_list_page.dart';

class GoodsSearchPage extends StatefulWidget {

  const GoodsSearchPage({super.key});

  @override
  _GoodsSearchPageState createState() => _GoodsSearchPageState();
}

class _GoodsSearchPageState extends State<GoodsSearchPage> {
  String _keyword = 'JJJJJJJJJJJ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySearchBar(
        hintText: 'Search by phone (Online)',
        onPressed: (text) =>           setState(() {
          _keyword = text;
        }),
      ),
      body: GoodsListPage(key: ValueKey(_keyword),index: 1, searchKeyword: _keyword,)
    );
  }
}
