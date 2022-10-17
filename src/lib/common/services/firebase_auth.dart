import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:src/common/model/birth_model.dart';
import 'package:src/common/model/sapi_model.dart';

import '../model/breeding_model.dart';
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

  ///User Sections
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

  ///Cow Section
  Future<DocumentReference<Map<String, dynamic>>?> tambahSapi(
      CowModel sapi, User _user) async {
    var res = await _usersCollection
        .doc(_user.uid)
        .collection('sapi')
        .add(sapi.toJson());
    Logger().w(res);
    return res;
  }

  Future<List<CowModel>> getSapi(User _user, {String? keywords}) async {
    return _usersCollection.doc(_user.uid).collection('sapi').get().then(
      (value) {
        if (keywords != null) {
          return value.docs
              .map((e) => CowModel.fromJson(e.data()))
              .where((element) =>
                  element.name!.toLowerCase().contains(keywords.toLowerCase()))
              .toList();
        } else {
          return value.docs.map((e) => CowModel.fromJson(e.data())).toList();
        }
      },
    );
  }

  Future<List<CowModel>> getSapiF(User _user, {String? keywords}) async {
    return _usersCollection.doc(_user.uid).collection('sapi').get().then(
      (value) {
        if (keywords != null) {
          return value.docs
              .map((e) => CowModel.fromJson(e.data()))
              .where((element) => (element.name!
                      .toLowerCase()
                      .contains(keywords.toLowerCase()) &&
                  element.gender == 0))
              .toList();
        } else {
          return value.docs
              .map((e) => CowModel.fromJson(e.data()))
              .where((element) => element.gender == 0)
              .toList();
        }
      },
    );
  }

  Future<CowModel?> getDetailSapi(User _user, String? cowId) async {
    return _usersCollection.doc(_user.uid).collection('sapi').get().then(
      (value) {
        return value.docs.map((e) => CowModel.fromJson(e.data())).firstWhere(
              (element) => element.id == cowId,
              orElse: () => CowModel(),
            );
      },
    );
  }

  ///Breeding Section

  Future<List<BreedingModel>> getBreeding(User _user, String cowId) async {
    return _usersCollection.doc(_user.uid).collection('tb_breeding').get().then(
      (value) {
        Logger().wtf(value.docs);
        return value.docs
            .map((e) => BreedingModel.fromJson(e.data()))
            .where((element) => element.cowId == cowId)
            .toList();
      },
    );
  }

  Future<DocumentReference<Map<String, dynamic>>?> submitBreeding(
      User _user, BreedingModel data) async {
    var res = await _usersCollection
        .doc(_user.uid)
        .collection('tb_breeding')
        .add(data.toJson());
    Logger().wtf(res);
    return res;
  }

  //Birth Sections
  Future<List<BirthModel>> getListBirth(User _user, String breedId) async {
    var res =
        await _usersCollection.doc(_user.uid).collection('tb_birth').get().then(
      (value) {
        print(breedId);
        Logger().wtf(value.docs.first.data());
        return value.docs
            .map((e) => BirthModel.fromJson(e.data()))
            .where((element) => element.breedingId == breedId)
            .toList();
      },
    );
    Logger().wtf(res);
    return res;
  }

  Future<DocumentReference<Map<String, dynamic>>?> submitBirth(
      User _user, BirthModel data) async {
    var res = await _usersCollection
        .doc(_user.uid)
        .collection('tb_birth')
        .add(data.toJson());
    Logger().wtf(res);
    return res;
  }
}
