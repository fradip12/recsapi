import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {

  /// Put All logic on controller

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /// Function
  
  Future login(BuildContext context) async {
    print('Masuk gan');
    Navigator.pushNamed(context, '/home');


  }

}