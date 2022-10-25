import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/services/firebase_auth.dart';

class SignupController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> repeatPasswordController =
      TextEditingController().obs;
  @override
  void onInit() {
    nameController.value.text = 'Test buat akun';
    emailController.value.text = 'testcreateakun2@yopmail.com';
    passwordController.value.text = '1234@Qwer';
    repeatPasswordController.value.text = '1234@Qwer';
    super.onInit();
  }

  Future<void> signUp() async {
    if (validateEmail(emailController.value.text)) {
      if (passwordController.value.text ==
          repeatPasswordController.value.text) {
        var res = await FireAuth.registerUsingEmailPassword(
          name: nameController.value.text,
          email: emailController.value.text,
          password: passwordController.value.text,
        );
        Logger().wtf(res);
        if (res != null) {
          Get.toNamed('/');
          Get.snackbar(
            'Success',
            'Silahkan Login menggunakan email',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Password tidak Sama',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Email tidak valid',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }
}
