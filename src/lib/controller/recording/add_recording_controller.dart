import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/model/sapi_model.dart';

class AddRecordingController extends GetxController {
  final List<String> stepper = ['Kelahiran', 'Tubuh', 'Catatan'].obs;

  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  Rx<int> activeSteps = 0.obs;
  Rx<int> selectedGender = 0.obs;
  Rx<int> hasilKawinDg = 0.obs;
  RxList<CowModel> listPejantan = <CowModel>[].obs;
  Rx<CowModel> selectedPejantan = CowModel.empty().obs;
  //Function

  void continueStep() {
    if (activeSteps.value != stepper.length - 1) {
      activeSteps.value += 1;
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
}
