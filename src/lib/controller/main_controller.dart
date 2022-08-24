import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/model/user_model.dart';

/// Main Controller for setting up everythings
class MainController extends GetxController {
  late Rx<User> user;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    super.onInit();
  }

  //Function

  void setupUser(User _user) async {
    user = _user.obs;
    _usersCollection.doc(_user.uid).get().then(
      (value) {
        if (!value.exists) {
          _usersCollection.doc(_user.uid).set(
                UserModel(
                  id: _user.uid,
                  displayName: _user.displayName,
                  email: _user.email,
                  phoneNumber: _user.phoneNumber,
                  tenantId: _user.tenantId,
                ).toJson(),
              );
        }
      },
    );
  }
}
