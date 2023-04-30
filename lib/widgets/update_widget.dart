import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/controllers/update_controller.dart';
import 'package:to_do/models/users_model.dart';
import 'package:to_do/utils/theme.dart';

class UpdateWidget extends GetView<AuthController> {
  const UpdateWidget({super.key, this.user});
  final UsersModel? user;
  @override
  Widget build(BuildContext context) {
    final updateController = Get.put(UpdateController());
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: CColors.mainColor,
      content: Container(
        padding: const EdgeInsets.all(5),
        width: Get.width,
        height: Get.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.x,
                          color: CColors.white,
                          size: 15,
                        ),
                        onPressed: () {
                          Get.back();
                        }),
                  ),
                ),
              ],
            ),
            const Center(
              child:
                  Text("UPDATE YOUR PROFILE", style: TextStyle(color: CColors.white, fontSize: 25)),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: updateController.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: CColors.white,
                  focusedErrorBorder: const OutlineInputBorder(gapPadding: 0),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: "Update name",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: updateController.dateBirth,
                    onTap: () async {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (date) {
                          updateController.date.value = date;
                          updateController.dateBirth.text =
                              "${date.day.toString().padLeft(2, "0")}.${date.month.toString().padLeft(2, "0")}.${date.year}";
                        },
                        currentTime: DateTime.now(),
                        maxTime: DateTime.now(),
                      );
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
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
                    value: updateController.selected.value,
                    elevation: 16,
                    style: const TextStyle(color: CColors.backgroundcolor),
                    onChanged: (String? value) {
                      updateController.selected.value = value ?? updateController.selected.value;
                    },
                    items: ["Male", "Female", "I don't want to specify"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: updateController.selected.value == value
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
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    child: const Text("Update"),
                    onPressed: () {
                      updateController.updateUser();
                      Get.back();
                    },
                  ),
                )),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
