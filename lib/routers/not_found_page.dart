import 'package:flutter/material.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';

class NotFoundPage extends StatelessWidget {

  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: '页面不存在',
      ),
    );
  }
}
