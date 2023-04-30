import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/todo_controller.dart';
import 'package:to_do/utils/theme.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ToDoController());

    return AlertDialog(
      backgroundColor: CColors.mainColor,
      content: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: TextField(
            controller: controller.task,
            style: const TextStyle(color: CColors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: CColors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CColors.mainColor, width: 5),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Enter a task",
              suffixIcon: Obx(
                () => AnimatedScale(
                  scale: controller.taskText.value.isNotEmpty ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: controller.task.clear,
                  ),
                ),
              ),
              hintStyle: const TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
            const SizedBox(
              width: 170,
            ),
            TextButton(
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onPressed: () {
                controller.addTODO();
                Get.back();
              },
            ),
          ],
        ),
      ],
    );
  }
}
