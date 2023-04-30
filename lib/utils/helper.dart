import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Helper {
  static Future<void> showError(String title, String msg) async {
    debugPrint(msg);
    return await EasyLoading.showError(
      msg,
      dismissOnTap: true,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void showToast(String text) =>
      EasyLoading.showToast(text, toastPosition: EasyLoadingToastPosition.bottom);
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
