import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/common/services/snack.dart';

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
    if (user != null) {
      Misc().snackbar(
        title: 'Login Detected',
        message: user.uid,
        color: Colors.greenAccent,
      );
      Get.offAllNamed('/home');
    } else {
      Misc().snackbar(
        title: 'Login Failed',
        message: 'Check Username and password again',
        color: Colors.red,
      );
    }
  }
}
