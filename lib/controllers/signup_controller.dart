import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/models/users_model.dart';

class SignUpController extends GetxController {
  final name = TextEditingController();
  final dateBirth = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordShow = true.obs;
  final confirmPasswordShow = true.obs;
  final confirmpassword = TextEditingController();
  final male = TextEditingController();

  final date = DateTime.now().obs;
  final selected = "Male".obs;

  @override
  void onClose() {
    name.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
    male.clear();
    dateBirth.clear();
    dateBirth.dispose();
    super.onClose();
  }

  Future<void> signUp() async {
    if (name.text.isEmpty || email.text.isEmpty) {
      EasyLoading.showError("There is an empty textfield");
    }
    final user = UsersModel(
      id: "",
      fullName: name.text,
      birthdayDate: date.value,
      email: email.text,
      gender: selected.value,
    );
    AuthController.to.signIn('emailSignUp',
        email: email.text.trim(), password: password.text.trim(), user: user);
  }
}
