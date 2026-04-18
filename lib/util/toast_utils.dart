
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// Toast工具类
class Toast {
  static void show(String? msg, {int duration = 2000, Color? backgroundColor=Colors.black54 }) {
    if (msg == null) {
      return;
    }
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: true,
      backgroundColor: backgroundColor
    );
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
