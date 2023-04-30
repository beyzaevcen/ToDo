import 'package:get/get.dart';
import 'package:to_do/controllers/auth_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }

  static void resetProfileControllers({required bool isLogin}) {
    try {} catch (_) {}
  }
}
