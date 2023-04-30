import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:to_do/controllers/signup_controller.dart';

class DateTimeWidget extends StatelessWidget {
  final String text;

  const DateTimeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: controller.dateBirth,
            onTap: () async {
              DatePicker.showDatePicker(
                context,
                onConfirm: (date) {
                  controller.date.value = date;
                  controller.dateBirth.text =
                      "${date.day.toString().padLeft(2, "0")}.${date.month.toString().padLeft(2, "0")}.${date.year}";
                },
                currentTime: DateTime.now(),
                maxTime: DateTime.now(),
              );
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
            ),
          ),
        ),
      ),
    );
  }
}
