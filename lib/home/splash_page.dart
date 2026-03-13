import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bounty_hunter/demo/demo_page.dart';
import 'package:bounty_hunter/login/login_router.dart';
import 'package:bounty_hunter/order/order_router.dart';
import 'package:bounty_hunter/res/constant.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/app_navigator.dart';
import 'package:bounty_hunter/util/device_utils.dart';
import 'package:bounty_hunter/util/image_utils.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/fractionally_aligned_sized_box.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sp_util/sp_util.dart';
import '../../routers/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        void precacheImages(String image) {
          precacheImage(ImageUtils.getAssetImage(image, format: ImageFormat.webp), context);
        }
        _guideList.forEach(precacheImages);
      }
      _initSplash();
    });

    if (Device.isAndroid) {
      const QuickActions quickActions = QuickActions();
      quickActions.initialize((String shortcutType) async {
        if (shortcutType == 'demo') {
          AppNavigator.pushReplacement(context, const DemoPage());
          _subscription?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
        final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
        if (accessToken.isNotEmpty) {
          NavigatorUtils.push(context, Routes.home, clearStack: true);
        } else {
          _goLogin();
        }
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.backgroundColor,
      child: _status == 0 ?
      const FractionallyAlignedSizedBox(
        heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
        child: LoadAssetImage('logo')
      ) :
      Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_, index) {
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            format: ImageFormat.webp,
          );
        },
        onTap: (index) {
          if (index == _guideList.length - 1) {
            _goLogin();
          }
        },
      )
    );
  }
}
