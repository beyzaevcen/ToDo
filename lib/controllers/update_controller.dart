import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/models/users_model.dart';
import 'package:to_do/services/user_api.dart';

class UpdateController extends GetxController {
  final dateBirth = TextEditingController(
      text:
          "${AuthController.to.profile.value!.birthdayDate.day.toString().padLeft(2, "0")}.${AuthController.to.profile.value!.birthdayDate.month.toString().padLeft(2, "0")}.${AuthController.to.profile.value!.birthdayDate.year}");
  final male = TextEditingController();
  final selected = AuthController.to.profile.value!.gender.obs;
  final date = DateTime.now().obs;
  final updatedName = AuthController.to.profile.value!.fullName;
  final name = TextEditingController();

  @override
  void onInit() {
    name.text = updatedName;
    super.onInit();
  }

  @override
  void onClose() {
    dateBirth.dispose();
    male.dispose();
    name.dispose();
    super.onClose();
  }

  void updateUser() {
    final updateUser = UsersModel(
        fullName: name.text,
        gender: selected.value,
        birthdayDate: date.value,
        email: AuthController.to.profile.value!.email,
        id: AuthController.to.profile.value!.id);

    male.clear();
    AuthController.to.profile.value = AuthController.to.profile.value
        ?.copyWith(fullName: name.text, gender: selected.value, birthdayDate: date.value);
    UserApi.updateUser(updateUser);
  }
}
