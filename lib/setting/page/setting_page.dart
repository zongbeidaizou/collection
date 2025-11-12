import 'package:flutter/material.dart';
-import 'package:bounty_hunter/res/constant.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/setting/provider/locale_provider.dart';
import 'package:bounty_hunter/setting/provider/theme_provider.dart';
import 'package:bounty_hunter/setting/widgets/exit_dialog.dart';
import 'package:bounty_hunter/setting/widgets/update_dialog.dart';
import 'package:bounty_hunter/widgets/click_item.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../setting_router.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Setting',
      ),
      body: Consumer2<ThemeProvider, LocaleProvider>(
        builder:
            (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
          return Column(
            children: <Widget>[
              Gaps.vGap5,
              ClickItem(
                title: 'Message Template',
                onTap: () {
                  NavigatorUtils.push(
                      context, SettingRouter.messageTemplatePage);
                },
              ),
              ClickItem(
                title: 'Sign out',
                onTap: _showExitDialog,
              ),
            ],
          );
        },
      ),
    );
  }

  String _getCurrentTheme() {
    final String? theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }
    return themeMode;
  }

  String _getCurrentLocale() {
    final String? locale = SpUtil.getString(Constant.locale);
    String localeMode;
    switch (locale) {
      case 'zh':
        localeMode = '中文';
        break;
      case 'en':
        localeMode = 'English';
        break;
      default:
        localeMode = '跟随系统';
        break;
    }
    return localeMode;
  }

  void _showExitDialog() {
    showDialog<void>(context: context, builder: (_) => const ExitDialog());
  }

  void _showUpdateDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const UpdateDialog());
  }
}
