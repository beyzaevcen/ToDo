import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:to_do/controllers/global_bindings.dart';
import 'package:to_do/controllers/todo_controller.dart';
import 'package:to_do/models/users_model.dart';
import 'package:to_do/screens/signup_page.dart';
import 'package:to_do/services/user_api.dart';
import 'package:to_do/utils/helper.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final user = Rxn<User>();
  final profile = Rxn<UsersModel>();

  bool onResendModal = false;
  final loginLoading = true.obs;

  String? appleName;

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    ever(user, (_) async {
      if (user.value == null) {
        profile.value = null;
        loginLoading.value = false;
        return;
      }
      loginLoading.value = true;

      if (appleName != null) await user.value?.updateDisplayName(appleName);
      profile.value = await UserApi.getUser(user.value!.uid);
      loginLoading.value = false;
      if (profile.value == null) {
        EasyLoading.dismiss();

        await Get.to(const SignUp());
      }
    });

    ever(profile, (_) {
      if (profile.value != null) {
        GlobalBindings.resetProfileControllers(isLogin: true);
      }
    });
    super.onInit();
  }

  Future<void> signIn(
    String platform, {
    String? email,
    String? password,
    UsersModel? user,
  }) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      switch (platform) {
        case "google":
          await signInWithGoogle();
          break;
        case "apple":
          await signInWithApple();
          break;
        case "emailSignIn":
          await signInWithEmail(email!, password!);
          EasyLoading.dismiss();
          break;
        case "emailSignUp":
          await signUpWithEmail(email!, password!, user!);
          break;
        default:
          Helper.showError(
            "not_implemented_tr".tr,
            '${platform.toUpperCase()} sign in is not implemented yet.',
          );
          EasyLoading.dismiss();
          break;
      }
    } catch (err) {
      debugPrint(err.toString());
      EasyLoading.dismiss();
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Helper.showToast("password_reset_link_send".tr);
      return true;
    } on FirebaseAuthException catch (_) {
      Helper.showToast("password_reset_link_send".tr);
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    onResendModal = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // if (!_auth.currentUser!.emailVerified) {
      //   final result = await VerifyModal.open(_auth.currentUser!);
      //   if (result != null) {
      //     Helper.showToast('verification_link_sent'.tr);
      //   }
      //   return;
      // }
      return;
    } on FirebaseAuthException catch (err) {
      Helper.showError("error".tr, err.code.tr);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password, UsersModel user) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await userCredential.user!.sendEmailVerification();
      // await signOut();
      user = user.copyWith(id: userCredential.user!.uid);
      final result = await UserApi.createUser(user);
      if (!result) {
        throw "user_creation_failed".tr;
      }
      profile.value = user;
      Get.back();
      Helper.showToast('registration_successful'.tr);
    } on FirebaseAuthException catch (err) {
      Helper.showError("error".tr, err.code.tr);
      rethrow;
    } catch (err) {
      Helper.showError("error".tr, err.toString().tr);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (err) {
      if (err.code != "unknown") Helper.showError("error".tr, err.code.tr);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = Helper.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      if (appleCredential.givenName != null && appleCredential.familyName != null) {
        appleName = "${appleCredential.givenName} ${appleCredential.familyName}";
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await _auth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (err) {
      Helper.showError("error".tr, err.code.tr);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);

      try {
        final googleSignIn = GoogleSignIn();
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.disconnect();
        }
      } catch (_) {}

      await _auth.signOut();
      Get.delete<ToDoController>();
    } catch (err) {
      debugPrint("Signout error : $err");
    }

    GlobalBindings.resetProfileControllers(isLogin: false);
    EasyLoading.dismiss();
  }
}
