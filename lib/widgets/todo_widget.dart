import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/todo_controller.dart';
import 'package:to_do/utils/theme.dart';

class ToDoWidget extends GetView<ToDoController> {
  const ToDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(controller.todoList.map((e) => Text(e.title)).toString()),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: CColors.mainColor),
          ),
          trailing: const Icon(
            Icons.circle_outlined,
            color: CColors.mainColor,
          ),
        )
      ],
    );
  }
}
