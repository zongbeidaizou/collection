
import 'package:flutter/material.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_search_bar.dart';

import 'account_record_list_page.dart';


class AccountSearchPage extends StatefulWidget {

  const AccountSearchPage({super.key});

  @override
  _AccountSearchPageState createState() => _AccountSearchPageState();
}

class _AccountSearchPageState extends State<AccountSearchPage> {
  String _keyword = 'JJJJJJJJJJJ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySearchBar(
        hintText: 'Search by phone or sn',
        onPressed: (text) =>           setState(() {
          _keyword = text;
        }),
      ),
      body: AccountRecordListPage(key: ValueKey(_keyword), searchKeyword:_keyword)
    );
  }
}
