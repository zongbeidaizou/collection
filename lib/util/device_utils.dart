import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:bounty_hunter/res/constant.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class Device {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;

  static late AndroidDeviceInfo _androidInfo;

  static Future<void> initDeviceInfo() async {
    if (isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      _androidInfo = await deviceInfo.androidInfo;
    }
  }

  /// 使用前记得初始化
  static int getAndroidSdkInt() {
    if (Constant.isDriverTest) {
      return -1;
    }
    if (isAndroid) {
      return _androidInfo.version.sdkInt;
    } else {
      return -1;
    }
  }

  /// 获取设备信息用于上传
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final Map<String, dynamic> deviceInfo = <String, dynamic>{};
    
    if (Constant.isDriverTest) {
      return deviceInfo;
    }

    try {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      
      if (isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceInfo['c_platform'] = 'android';
        deviceInfo['d_device_id'] = androidInfo.id;
        deviceInfo['e_device_model'] = androidInfo.model;
        deviceInfo['f_device_brand'] = androidInfo.brand;
        deviceInfo['g_device_manufacturer'] = androidInfo.manufacturer;
        deviceInfo['h_device_product'] = androidInfo.product;
        deviceInfo['i_device_version'] = androidInfo.version.release;
        deviceInfo['j_device_sdk_int'] = androidInfo.version.sdkInt;
        deviceInfo['k_device_hardware'] = androidInfo.hardware;
      } else if (isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo['c_platform'] = 'ios';
        deviceInfo['d_device_id'] = iosInfo.identifierForVendor;
        deviceInfo['e_device_model'] = iosInfo.model;
        deviceInfo['f_device_brand'] = iosInfo.name;
        deviceInfo['g_device_manufacturer'] = iosInfo.systemName;
        deviceInfo['i_device_version'] = iosInfo.systemVersion;
        deviceInfo['k_device_hardware'] = iosInfo.utsname.machine;
      } else if (isWeb) {
        deviceInfo['c_platform'] = 'web';
      } else {
        deviceInfo['c_platform'] = 'unknown';
      }
    } catch (e) {
      // 如果获取设备信息失败，至少返回平台信息
      if (isAndroid) {
        deviceInfo['c_platform'] = 'android';
      } else if (isIOS) {
        deviceInfo['c_platform'] = 'ios';
      } else if (isWeb) {
        deviceInfo['c_platform'] = 'web';
      } else {
        deviceInfo['c_platform'] = 'unknown';
      }
    }
    
    return deviceInfo;
  }
}
