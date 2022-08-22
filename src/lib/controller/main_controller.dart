import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// Main Controller for setting up everythings
class MainController extends GetxController {
  late Rx<User> user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //Function

  void setupUser(User _user) async {
    user = _user.obs;
  }
}
