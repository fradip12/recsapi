import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';

import '../main_controller.dart';

class AddSapiController extends GetxController {
  final List<String> stepper = ['Kelahiran', 'Tubuh', 'Catatan'].obs;

  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  final Rx<TextEditingController> codeController = TextEditingController().obs;
  final Rx<TextEditingController> bangsaController =
      TextEditingController().obs;
  final Rx<TextEditingController> warnaController = TextEditingController().obs;
  final Rx<TextEditingController> bobotLahirController =
      TextEditingController().obs;
  final Rx<TextEditingController> strowController = TextEditingController().obs;
  final MainController _mainController = Get.find<MainController>();

  Rx<int> activeSteps = 0.obs;
  Rx<int> selectedGender = 0.obs;
  Rx<int> hasilKawinDg = 0.obs;
  RxList<CowModel> listPejantan = <CowModel>[].obs;
  Rx<CowModel> selectedPejantan = CowModel.empty().obs;
  Rx<String> dateTime = ''.obs;

  //Function

  void init() async {
    getListPejantan();
  }

  void continueStep() {
    if (activeSteps.value != stepper.length - 1) {
      //Validate first
      var data = CowModel()
        ..name = usernameController.value.text
        ..id = codeController.value.text
        ..breed = bangsaController.value.text
        ..gender = selectedGender.value == 0 ? 0 : 1
        ..color = warnaController.value.text
        ..parentM = selectedPejantan.value.id
        ..strowNumber = strowController.value.text
        ..weightBirth = double.tryParse(bobotLahirController.value.text);

      activeSteps.value = activeSteps.value += 1;
      Logger().w(data.toJson());
    }
  }

  void backStep() {
    if (activeSteps.value != 0) {
      activeSteps.value -= 1;
    }
  }

  void switchGender() {
    if (selectedGender.value == 0) {
      selectedGender.value = 1;
    } else if (selectedGender.value == 1) {
      selectedGender.value = 0;
    }
  }

  void switchHasilKawin() {
    if (hasilKawinDg.value == 0) {
      hasilKawinDg.value = 1;
    } else if (hasilKawinDg.value == 1) {
      hasilKawinDg.value = 0;
    }
  }

  Future<void> getListPejantan() async {
    var res = await FireStore().getSapi(_mainController.user.value);
    for (var element in res) {
      Logger().d(element.gender);
      if (element.gender == 1) {
        listPejantan.add(element);
      }
    }
  }
}
