import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/screens/home_page.dart';
import 'package:to_do/screens/login_page.dart';

class RootWrapper extends GetView<AuthController> {
  const RootWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.user.value != null ? const HomePage() : const LoginPage());
  }
}
