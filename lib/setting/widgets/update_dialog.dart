import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/image_utils.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/util/version_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';


class UpdateDialog extends StatefulWidget {

  const UpdateDialog({super.key, required this.version});

  final String version;

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  
  final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;
  
  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return PopScope(
      canPop: false, /// 使用false禁止返回键返回，达到强制升级目的
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 120.0,
                width: 280.0,
              ),
              Container(
                width: 280.0,
                decoration: BoxDecoration(
                  color: context.dialogBackgroundColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('new version available', style: TextStyles.textSize16),
                    Gaps.vGap15,
                    if (_isDownload)
                      LinearProgressIndicator(
                        backgroundColor: Colours.line,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        value: _value,
                      )
                    else
                      _buildButton(context),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: 'Reject',
            fontSize: Dimens.font_sp16,
            textColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
            side: BorderSide(
              color: primaryColor,
              width: 0.8,
            ),
            backgroundColor: Colors.transparent,
            onPressed: () {
              NavigatorUtils.goBack(context);
            },
          ),
        ),
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: 'Update',
            fontSize: Dimens.font_sp16,
            onPressed: () {
              if (defaultTargetPlatform == TargetPlatform.iOS) {
                NavigatorUtils.goBack(context);
                VersionUtils.jumpAppStore();
              } else {
                setState(() {
                  _isDownload = true;
                });
                _download();
              }
            },
            textColor: Colors.white,
            backgroundColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
          ),
        )
      ],
    );
  }

  String _getApkUrlByAbi() {
    final String version = widget.version;
    const String base = 'https://uganda.rock6.xyz/static/d';

    // 通过当前运行架构选择下载包（Dart FFI Abi 枚举）
    final Abi abi = Abi.current();
    if (abi == Abi.androidArm64) {
      return '$base/app-arm64-v8a-release-$version.apk';
    }
    if (abi == Abi.androidArm) {
      return '$base/app-armeabi-v7a-release-$version.apk';
    }

    // 兜底：优先给 64 位包
    return '$base/app-arm64-v8a-release-$version.apk';
  }

  ///下载apk
  Future<void> _download() async {
    try {
      setInitDir(initStorageDir: true);
      await DirectoryUtil.getInstance();
      DirectoryUtil.createStorageDirSync(category: 'Download');
      final String path = DirectoryUtil.getStoragePath(fileName: 'dasewan', category: 'Download', format: 'apk').nullSafe;
      final File file = File(path);
      final String apkUrl = _getApkUrlByAbi();

      await Dio().download(
        apkUrl,
        file.path,
        cancelToken: _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            _value = count / total;
            setState(() {});
            if (count == total) {
              NavigatorUtils.goBack(context);
              VersionUtils.install(path);
            }
          }
        },
      );
    } catch (e) {
      Toast.show('Download failed!');
      debugPrint(e.toString());
      setState(() {
        _isDownload = false;
      });
    }
  }
}
