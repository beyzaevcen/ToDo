import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/models/to_do.dart';
import 'package:to_do/services/to_do_api.dart';

class ToDoController extends GetxController {
  final completedList = false.obs;
  final taskText = "".obs;
  final searchText = "".obs;
  final search = TextEditingController();
  final task = TextEditingController();

  final todoList = <TODO>[].obs;

  late StreamSubscription<List<TODO>> getTodosHandle;

  @override
  void onInit() {
    getTodosHandle = ToDoApi.getTodos().listen((event) {
      todoList.value = event;
    });
    task.clear();

    task.addListener(taskListener);
    search.addListener(searchListener);
    super.onInit();
  }

  @override
  void onClose() {
    task.removeListener(taskListener);
    search.removeListener(searchListener);
    task.dispose();
    getTodosHandle.cancel();
    todoList.clear();
    super.onClose();
  }

  void taskListener() => taskText.value = task.text.trim();

  void searchListener() => searchText.value = search.text.trim();

  List<TODO> get getFilters => todoList
      .where((p0) => !completedList.value || p0.completed)
      .where((e) => e.title.contains(searchText.value))
      .toList();

  void addTODO() async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();

    final todo = TODO(
      key: key,
      title: task.text,
      completed: false,
      tid: "",
    );
    await ToDoApi.createTodo(todo);

    task.clear();
  }

  void updateTodo(TODO toDo) {
    final updatedTodo = toDo.copyWith(completed: !toDo.completed);
    ToDoApi.updateTodo(updatedTodo);
  }

  void deleteToDo(TODO toDo) {
    ToDoApi.deleteToDo(toDo.tid);
  }

  void complatedTask(TODO e) {
    final todo = e.copyWith(completed: true);
    final i = todoList.indexWhere((e) => e.key == todo.key);
    if (i != -1) {
      todoList[i] = todo;
    }
  }
}
