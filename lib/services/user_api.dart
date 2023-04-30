import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/utils.dart';
import 'package:to_do/controllers/auth_controller.dart';
import 'package:to_do/models/users_model.dart';
import 'package:to_do/utils/helper.dart';

class UserApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> createUser(UsersModel user) async {
    try {
      await firestore.collection("users").doc(user.id).set(user.toMap());
      return true;
    } on FirebaseException catch (err) {
      Helper.showError("error".tr, err.code.tr);
      return false;
    } catch (err) {
      Helper.showError("error".tr, err.toString().tr);
      return false;
    }
  }

  static Future<UsersModel?> getUser(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> result =
          await firestore.collection("users").doc(uid).get();

      if (!result.exists) return null;
      final data = result.data();
      if (data != null) {
        return UsersModel.fromMap(data);
      }
    } on FirebaseException catch (err) {
      Helper.showError("error".tr, err.code.tr);
      return null;
    } catch (err) {
      Helper.showError("error".tr, err.toString().tr);
      return null;
    }
    return null;
  }

  static Future<UsersModel?> updateUser(UsersModel user) async {
    try {
      await firestore.collection("users").doc(AuthController.to.user.value!.uid).set(user.toMap());

      return user;
    } on FirebaseException catch (err) {
      Helper.showError("error", err.code);
      return null;
    } catch (err) {
      Helper.showError("error", err.toString());
      return null;
    }
  }
}
