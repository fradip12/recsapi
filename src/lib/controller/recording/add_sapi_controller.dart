import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/home/home_controller.dart';
import 'package:uuid/uuid.dart';

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
  final Rx<TextEditingController> weight4MController =
      TextEditingController().obs;
  final Rx<TextEditingController> weight1YController =
      TextEditingController().obs;
  final Rx<TextEditingController> ld1YController = TextEditingController().obs;
  final Rx<TextEditingController> pb1YController = TextEditingController().obs;
  final Rx<TextEditingController> tp1YsController = TextEditingController().obs;
  final Rx<TextEditingController> notesController = TextEditingController().obs;
  final MainController _mainController = Get.find<MainController>();

  Rx<int> activeSteps = 0.obs;
  Rx<int> selectedGender = 0.obs;
  Rx<int> hasilKawinDg = 0.obs;

  final _listPejantan = BehaviorSubject<List<CowModel>?>();
  Sink<List<CowModel>?> get listPejantanIn => _listPejantan.sink;
  Stream<List<CowModel>?> get listPejantanOut => _listPejantan.stream;

  final _listInduk = BehaviorSubject<List<CowModel>?>();
  Sink<List<CowModel>?> get listIndukIn => _listInduk.sink;
  Stream<List<CowModel>?> get listIndukOut => _listInduk.stream;

  final _selectedPejantan = BehaviorSubject<CowModel?>();
  Sink<CowModel?> get selectedPejantanIn => _selectedPejantan.sink;
  Stream<CowModel?> get selectedPejantanOut => _selectedPejantan.stream;

  final _selectedInduk = BehaviorSubject<CowModel?>();
  Sink<CowModel?> get selectedIndukIn => _selectedInduk.sink;
  Stream<CowModel?> get selectedIndukOut => _selectedInduk.stream;

  Rx<String> dateTime = ''.obs;

  Rx<String?> message = ''.obs;

  //Function

  void init() async {
    getListPejantan();
    getListInduk();
  }

  void _showWarning() {
    Get.snackbar(
      'Warning!',
      'Mohon melengkapi data yang bertanda *',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  bool isValid() {
    return isNotBlank(codeController.value.text) &&
        isNotBlank(usernameController.value.text) &&
        dateTime.value != '' &&
        (_selectedInduk.hasValue && _selectedInduk.value != null) &&
        ((_selectedPejantan.hasValue && _selectedPejantan.value != null) ||
            isNotBlank(strowController.value.text));
  }

  void continueStep() {
    var uuid = Uuid();

    if (activeSteps.value != stepper.length - 1) {
      if (activeSteps.value == 0) {
        if (!isValid()) {
          _showWarning();
        } else {
          activeSteps.value = activeSteps.value += 1;
        }
      } else {
        activeSteps.value = activeSteps.value += 1;
      }
    } else {
      //Validate first
      var data = CowModel()
        ..name = usernameController.value.text
        ..id = uuid.v5(
            Uuid.NAMESPACE_URL, (usernameController.value.text + uuid.v1()))
        ..uniqueId = codeController.value.text
        ..breed = bangsaController.value.text
        ..gender = selectedGender.value == 0 ? 0 : 1
        ..color = warnaController.value.text
        ..strowNumber = strowController.value.text
        ..weightBirth = double.tryParse(bobotLahirController.value.text)
        ..weight4Mo = double.tryParse(weight4MController.value.text)
        ..weight1Yo = double.tryParse(weight1YController.value.text)
        ..chestCircumference1Yo = double.tryParse(ld1YController.value.text)
        ..bodyLength1Yo = double.tryParse(pb1YController.value.text)
        ..gumbaHeight1Yo = double.tryParse(tp1YsController.value.text)
        ..parentF = _selectedInduk.value?.uniqueId
        ..birthdate = dateTime.value;

      if (_selectedPejantan.hasValue &&
          _selectedPejantan.value?.uniqueId != null) {
        data.parentM = _selectedPejantan.value?.uniqueId;
      }
      Logger().w(data.toJson());
      submit(data);
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
    print(selectedGender.value);
  }

  void switchHasilKawin() {
    if (hasilKawinDg.value == 0) {
      hasilKawinDg.value = 1;
    } else if (hasilKawinDg.value == 1) {
      hasilKawinDg.value = 0;
    }
  }

  Future<void> submit(CowModel data) async {
    var res = await FireStore().tambahSapi(data, _mainController.user.value);
    if (res != null) {
      Get.back();
      Get.back();
      Get.snackbar('Sukses', 'Berhasil Menambahkan Data',
          snackPosition: SnackPosition.BOTTOM);
      Get.find<HomeController>().refreshPages();
    } else {
      Get.snackbar('Error', 'Gagal Menambahkan Data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> getListPejantan() async {
    var res = await FireStore().getSapi(_mainController.user.value);
    var _list = <CowModel>[];
    for (var element in res) {
      if (element.gender == 1) {
        _list.add(element);
      }
    }
    _listPejantan.add(_list);
  }

  Future<void> getListInduk() async {
    var res = await FireStore().getSapiF(_mainController.user.value);

    _listInduk.add(res);
  }
}
