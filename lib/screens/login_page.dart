import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:to_do/controllers/login_controller.dart';
import 'package:to_do/screens/signup_page.dart';
import 'package:to_do/utils/theme.dart';
import 'package:to_do/widgets/continue_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: CColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              //Hello Again
              const Text(
                'Welcome Back ',
                style: TextStyle(fontSize: 30, color: CColors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 50,
              ),
              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: controller.email,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: CColors.white,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Obx(() => TextFormField(
                      obscureText: controller.passwordShow.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val != controller.password.text) {
                          return "lmcdsl";
                        }
                        return null;
                      },
                      controller: controller.password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (controller.passwordShow.value == false) {
                              controller.passwordShow.value = true;
                            } else {
                              controller.passwordShow.value = false;
                            }
                          },
                          icon: controller.passwordShow.value
                              ? const Icon(FontAwesomeIcons.eyeSlash)
                              : const Icon(FontAwesomeIcons.eye),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: CColors.white,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Password",
                      ),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 220, top: 10),
                child: Text(
                  "Forget Password?",
                  style: TextStyle(color: CColors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        controller.signIn();
                      },
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?',
                      style: TextStyle(
                        color: CColors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  InkWell(
                    onTap: () {
                      Get.to(const SignUp());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const ContinueWidget(
                text: "Continue with Android",
                icon: FontAwesomeIcons.android,
              ),

              const SizedBox(
                height: 10,
              ),
              const ContinueWidget(
                text: "Continue with Apple",
                icon: FontAwesomeIcons.apple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
