import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final passwordShow = true.obs;

  void signIn() {
    if (email.text.isEmpty || password.text.isEmpty) {
      EasyLoading.showError("There is an empty textfield");
    } else {
      AuthController.to
          .signIn('emailSignIn', email: email.text.trim(), password: password.text.trim());
    }
  }
}
