import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:src/common/services/firebase_auth.dart';

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
      Get.offAllNamed('/home');
    }
  }
}
