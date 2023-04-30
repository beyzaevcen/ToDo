import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/signup_controller.dart';
import 'package:to_do/utils/theme.dart';
import 'package:to_do/widgets/datetime_picker.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text("Sign Up"),
        backgroundColor: CColors.mainColor,
      ),
      backgroundColor: CColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: controller.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: CColors.white,
                    focusedErrorBorder: const OutlineInputBorder(gapPadding: 0),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "Full name",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const DateTimeWidget(text: "Date of Birth"),
              const SizedBox(
                height: 20,
              ),
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
                    focusedErrorBorder: const OutlineInputBorder(gapPadding: 0),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Obx(() => TextFormField(
                      obscureText: controller.passwordShow.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
                        focusedErrorBorder: const OutlineInputBorder(gapPadding: 0),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Password",
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Obx(() => TextFormField(
                      obscureText: controller.confirmPasswordShow.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val != controller.password.text) {
                          return "lmcdsl";
                        }
                        return null;
                      },
                      controller: controller.confirmpassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (controller.confirmPasswordShow.value == false) {
                              controller.confirmPasswordShow.value = true;
                            } else {
                              controller.confirmPasswordShow.value = false;
                            }
                          },
                          icon: controller.confirmPasswordShow.value
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
                        hintText: "Confirm Password",
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const SizedBox(),
                      value: controller.selected.value,
                      elevation: 16,
                      style: const TextStyle(color: CColors.backgroundcolor),
                      onChanged: (String? value) {
                        controller.selected.value = value ?? controller.selected.value;
                      },
                      items: ["Male", "Female", "I don't want to specify"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: controller.selected.value == value
                                    ? CColors.black
                                    : CColors.subtitleColor),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
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
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        controller.signUp();
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
