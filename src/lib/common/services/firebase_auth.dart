import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:src/common/model/sapi_model.dart';

import '../model/user_model.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
}

class FireStore {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> setupUser(User _user) async {
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

  Future<void> tambahSapi(CowModel sapi, User _user) async {
    _usersCollection.doc(_user.uid).collection('sapi').add(sapi.toJson());
  }
}
