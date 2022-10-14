import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

class SapiSayaController extends GetxController {
  //Var
  final MainController _mainController = Get.find<MainController>();

  final _sapiSaya = BehaviorSubject<List<CowModel>?>.seeded([]);
  Stream<List<CowModel>?> get sapiSayaStream =>
      _sapiSaya.stream.delay(Duration(seconds: 2));
  Sink<List<CowModel>?> get sapiSayaSink => _sapiSaya.sink;

  final _searchListener = BehaviorSubject<String?>.seeded(null);
  Stream<String?> get searchListenerStream => _searchListener.stream;
  Sink<String?> get searchListenerSink => _searchListener.sink;

  //Function

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    getSapiSaya();
    refresh();
  }

  Future<void> tambahSapi() async {
    Get.toNamed('/add-sapi');
  }

  getSapiSaya() async {
    if (_sapiSaya.hasValue) {
      _sapiSaya.value = null;
    }
    var res = await FireStore()
        .getSapi(_mainController.user.value, keywords: _searchListener.value);
    _sapiSaya.add(res);
  }
}
