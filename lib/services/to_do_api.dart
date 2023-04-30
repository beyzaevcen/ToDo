import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/models/to_do.dart';
import 'package:to_do/utils/helper.dart';

class ToDoApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> createTodo(TODO todo) async {
    try {
      final result = firestore
          .collection("users")
          .doc(AuthController.to.user.value!.uid)
          .collection("todo")
          .doc();

      todo = todo.copyWith(tid: result.id);
      await result.set(todo.toMap());
      return true;
    } on FirebaseException catch (err) {
      Helper.showError("error", err.code);
      return false;
    } catch (err) {
      Helper.showError("error", err.toString());
      return false;
    }
  }

  static Stream<List<TODO>> getTodos() {
    final results = firestore
        .collection("users")
        .doc(AuthController.to.user.value!.uid)
        .collection("todo")
        .orderBy("key", descending: true)
        .snapshots();
    return results.map((event) => event.docs.map((e) => TODO.fromMap(e.data())).toList());
  }

  static Future<TODO?> updateTodo(TODO todo) async {
    try {
      await firestore
          .collection("users")
          .doc(AuthController.to.user.value!.uid)
          .collection("todo")
          .doc(todo.tid)
          .set(todo.toMap());

      return todo;
    } on FirebaseException catch (err) {
      Helper.showError("error", err.code);
      return null;
    } catch (err) {
      Helper.showError("error", err.toString());
      return null;
    }
  }

  static Future<bool> deleteToDo(String tid) async {
    try {
      await firestore
          .collection("users")
          .doc(AuthController.to.user.value!.uid)
          .collection("todo")
          .doc(tid)
          .delete();

      return true;
    } on FirebaseException catch (err) {
      Helper.showError("error", err.code);
      return false;
    } catch (err) {
      Helper.showError("error", err.toString());
      return false;
    }
  }
}
