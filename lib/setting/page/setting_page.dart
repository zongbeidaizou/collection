import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/constant.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/setting/provider/locale_provider.dart';
import 'package:bounty_hunter/setting/provider/theme_provider.dart';
import 'package:bounty_hunter/setting/widgets/exit_dialog.dart';
import 'package:bounty_hunter/setting/widgets/update_dialog.dart';
import 'package:bounty_hunter/widgets/click_item.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:flutter/services.dart';

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
              // ClickItem(
              //   title: 'Message Template',
              //   onTap: () {
              //     NavigatorUtils.push(
              //         context, SettingRouter.messageTemplatePage);
              //   },
              // ),
              // ClickItem(
              //   title: 'WhatsApp Activation',
              //   onTap: () {
              //     NavigatorUtils.push(context, SettingRouter.waActivationPage);
              //   },
              // ),
              ClickItem(
                title: 'Sign out',
                onTap: _showExitDialog,
              ),
              ClickItem(
                title: 'Update Password',
                onTap: _showChangePasswordDialog,
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

  void _showChangePasswordDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        final TextEditingController controller = TextEditingController();
        String? errorText;
        bool canSubmit = false;

        bool hasConsecutiveRun(String s) {
          if (s.length < 4) return false;
          final List<int> digits =
              s.split('').map((String e) => int.tryParse(e) ?? 0).toList();
          for (int i = 0; i <= digits.length - 4; i++) {
            bool asc = true;
            bool desc = true;
            for (int j = 0; j < 4; j++) {
              if (digits[i + j] != digits[i] + j) asc = false;
              if (digits[i + j] != digits[i] - j) desc = false;
            }
            if (asc || desc) return true;
          }
          return false;
        }

        void validate(String v) {
          final String pwd = v.trim();
          errorText = null;
          canSubmit = false;

          if (pwd.length != 6) {
            errorText = 'Enter 6-digit password';
            return;
          }

          if (hasConsecutiveRun(pwd)) {
            errorText = 'Password cannot contain 4 consecutive digits';
            return;
          }

          canSubmit = true;
        }

        validate('');

        return StatefulBuilder(
          builder: (BuildContext _, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text('Update Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: controller,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter 6-digit new password',
                      errorText: errorText,
                      counterText: '',
                    ),
                    onChanged: (String v) {
                      setState(() {
                        validate(v);
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Rule: cannot contain 4 consecutive increasing/decreasing numbers',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: canSubmit
                      ? () async {
                          final String pwd = controller.text.trim();
                          try {
                            final formData = FormData.fromMap({
          'password': pwd,
        });
                            await DioUtils.instance.requestNetwork<Map<String, dynamic>>(
                              Method.post,
                              HttpApi.updatePassword,
                              params: formData,
                              onSuccess: (Map<String, dynamic>? data) {
                                final bool success =
                                    (data?['success'] == true) ||
                                        (data?['code'] == 0);
                                final String msg = (data?['errorMessage'] as String?) ??
                                    (data?['message'] as String?) ??
                                    'update password success';

                                Navigator.of(dialogContext).pop();
                                Toast.show(success ? 'update password success' : msg);
                              },
                              onError: (int _, String msg) {
                                Toast.show(msg);
                              },
                            );
                          } catch (e) {
                            Toast.show('update password failed');
                          }
                        }
                      : null,
                  child: const Text('confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const UpdateDialog());
  }
}
