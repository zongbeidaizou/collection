
import 'package:flutter/material.dart';
import 'package:bounty_hunter/main.dart';
import 'package:bounty_hunter/res/constant.dart';
import 'package:bounty_hunter/setting/page/setting_page.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:sp_util/sp_util.dart';

/// 运行 flutter drive --target=test_driver/setting/setting.dart
Future<void> main() async {
  enableFlutterDriverExtension();
  Constant.isDriverTest = true;
  WidgetsFlutterBinding.ensureInitialized();
  /// sp初始化
  await SpUtil.getInstance();
  runApp(MyApp(home: const SettingPage()));
}
