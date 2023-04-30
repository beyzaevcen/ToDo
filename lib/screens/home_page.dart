import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/utils/theme.dart';
import 'package:to_do/widgets/task_widget.dart';
import 'package:to_do/widgets/update_widget.dart';

import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ToDoController());
    const icon = Icon(
      Icons.check_box,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.purple[40],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.user),
          onPressed: () => Get.dialog((const UpdateWidget())),
        ),
        title: const Text("TO DO"),
        backgroundColor: CColors.mainColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                AuthController().signOut();
              },
              icon: const Icon(FontAwesomeIcons.doorOpen))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(const TaskWidget()),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.search,
              style: const TextStyle(color: CColors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: CColors.mainColor, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: "🔎 Search",
                suffixIcon: Obx(
                  () => AnimatedScale(
                    scale: controller.searchText.value.isNotEmpty ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: controller.search.clear,
                    ),
                  ),
                ),
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 5, color: CColors.black),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            Obx(
              () => controller.todoList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: controller.completedList.toggle,
                        child: Ink(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CColors.mainColor,
                          ),
                          child: Center(
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 32),
                                  controller.completedList.value == true
                                      ? const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: CColors.white,
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: CColors.white,
                                        ),
                                  const SizedBox(width: 32),
                                  Text(
                                    controller.completedList.value == true
                                        ? "Back all tasks "
                                        : "Show completed tasks",
                                    style: const TextStyle(color: CColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            const Center(
              child: Text(
                "♡All ToDos",
                style: TextStyle(color: CColors.black, fontSize: 30.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.getFilters.isNotEmpty
                  ? Column(
                      children: controller.getFilters
                          .map(
                            (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  tileColor: e.completed ? Colors.deepPurple : null,
                                  leading: e.completed
                                      ? icon
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.deepPurple,
                                        ),
                                  onTap: () {
                                    controller.updateTodo(e);
                                  },
                                  title: Text(
                                    e.title,
                                    style: TextStyle(
                                        color: e.completed ? Colors.white : Colors.black,
                                        decoration: e.completed
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(color: CColors.mainColor),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: e.completed ? CColors.white : Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      controller.deleteToDo(e);
                                    },
                                  ),
                                )),
                          )
                          .toList(),
                    )
                  : const EmptyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/gif.json'),
        const Text(
          "There is no task",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
