import 'package:flutter/material.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_search_bar.dart';

class AddressSelectPage extends StatefulWidget {

  const AddressSelectPage({super.key});

  @override
  _AddressSelectPageState createState() => _AddressSelectPageState();
}

class _AddressSelectPageState extends State<AddressSelectPage> {
  
  int _index = 0;
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MySearchBar(
        hintText: '搜索地址',
        onPressed: (text) {
          _controller.animateTo(0.0, duration: const Duration(milliseconds: 10), curve: Curves.ease);
          _index = 0;
        },
      ),
      body: SafeArea(
        child: Text("123"),
      ),
    );
  }
}

