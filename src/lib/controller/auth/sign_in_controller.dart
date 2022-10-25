import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/common/services/snack.dart';
import 'package:src/controller/main_controller.dart';

class SignInController extends GetxController {
  //Var

  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  /// Put All logic on controller
  @override
  void onInit() {
    super.onInit();
  }

  /// Function

  Future<void> login(BuildContext context) async {
    User? user = await FireAuth.signInUsingEmailPassword(
      email: usernameController.value.text,
      password: passwordController.value.text,
      context: context,
    );
    Logger().wtf(usernameController.value.text);
    Logger().wtf(passwordController.value.text);
    Logger().wtf(user);
    if (user != null) {
      Misc().snackbar(
        title: 'Login Detected',
        message: user.uid,
        color: Colors.greenAccent,
      );
      Get.offAllNamed('/home');
      Get.put(MainController()).setupUser(user);
    } else {
      Misc().snackbar(
        title: 'Login Failed',
        message: 'Check Username and password again',
        color: Colors.red,
      );
    }
  }

  Future<void> loginGoogle(BuildContext context) async {
    User? user = await FireAuth.signInWithGoogle();

    Logger().wtf(user);
    if (user != null) {
      Misc().snackbar(
        title: 'Login Detected',
        message: user.uid,
        color: Colors.greenAccent,
      );
      Get.offAllNamed('/home');
      Get.put(MainController()).setupUser(user);
    } else {
      Misc().snackbar(
        title: 'Login Failed',
        message: 'Check Username and password again',
        color: Colors.red,
      );
    }
  }
}
