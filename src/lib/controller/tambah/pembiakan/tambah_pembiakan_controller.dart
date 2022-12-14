import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/breeding_model.dart';
import 'package:src/controller/main_controller.dart';
import 'package:src/controller/tambah/pembiakan/pembiakan_detail_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../common/model/sapi_model.dart';
import '../../../common/services/firebase_auth.dart';

class TambahPembiakanController extends GetxController {
  final PembiakanDetailController pembiakanController =
      Get.find<PembiakanDetailController>();
  final MainController _mainController = Get.find<MainController>();

  Rx<int> hasilKawinDg = 0.obs;
  Rx<int> buntingState = 0.obs;
  Rx<String?> dateTime = ''.obs;
  final _selectedPejantan = BehaviorSubject<CowModel?>();
  Sink<CowModel?> get selectedPejantanIn => _selectedPejantan.sink;
  Stream<CowModel?> get selectedPejantanOut => _selectedPejantan.stream;

  final _listPejantan = BehaviorSubject<List<CowModel>?>();
  Sink<List<CowModel>?> get listPejantanIn => _listPejantan.sink;
  Stream<List<CowModel>?> get listPejantanOut => _listPejantan.stream;

  Rx<int> selectedSC = 1.obs;
  RxList<int> listSC = [1, 2, 3, 4].obs;

  final Rx<TextEditingController> strowController = TextEditingController().obs;
  final Rx<TextEditingController> idPembiakan = TextEditingController().obs;

  final _cowModel = BehaviorSubject<CowModel?>.seeded(null);
  Sink<CowModel?> get cowModel => _cowModel.sink;
  Stream<CowModel?> get cowModelStream => _cowModel.stream;

  late TambahPembiakanArguments args;

  final _isEdit = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isEditOut => _isEdit.stream;

  @override
  void onInit() {
    super.onInit();
    getListPejantan();
    pembiakanController.outCowModel.listen((event) {
      cowModel.add(event);
    });
    Logger().wtf(_cowModel);
    if (Get.arguments != null) {
      args = Get.arguments as TambahPembiakanArguments;
      _isEdit.add(args.editData != null);
      initEditData();
    }
  }

  void initEditData() {
    dateTime.value = args.editData!.breedDate;
    hasilKawinDg.value = isNotBlank(args.editData!.maleId) ? 0 : 1;
    buntingState.value = args.editData?.pregnantState == true ? 1 : 0;
    if (buntingState.value == 1) {
      selectedSC.value = args.editData!.sc!;
    }
    if (hasilKawinDg.value == 1) {
      strowController.value.text = args.editData?.strowNumber ?? '';
    }
  }

  void switchHasilKawin() {
    if (hasilKawinDg.value == 0) {
      hasilKawinDg.value = 1;
    } else if (hasilKawinDg.value == 1) {
      hasilKawinDg.value = 0;
    }
  }

  void switchBuntingState() {
    if (buntingState.value == 0) {
      buntingState.value = 1;
    } else if (buntingState.value == 1) {
      buntingState.value = 0;
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
    if (_isEdit.value) {
      if (hasilKawinDg.value == 0) {
        _selectedPejantan.add(_list.firstWhere(
            (element) => element.uniqueId == args.editData!.maleId));
      }
    }
  }

  Future<void> submitTambahPembiakan() async {
    var uuid = Uuid();
    if (_isEdit.value) {
      if (isNotBlank(_cowModel.value!.id) && selectedSC.value != 0) {
        try {
          var breeding = BreedingModel();
          breeding.breedDate = dateTime.value;
          breeding.cowId = _cowModel.value!.id;
          breeding.id = args.editData!.id;
          breeding.pregnantState = buntingState.value == 1 ? true : false;
          breeding.sc = buntingState.value == 0 ? 0 : selectedSC.value;
          if (_selectedPejantan.hasValue && _selectedPejantan.value != null) {
            breeding.maleId = _selectedPejantan.value!.uniqueId;
            breeding.maleName = _selectedPejantan.value!.name;
          }
          if (isNotBlank(strowController.value.text)) {
            breeding.strowNumber = strowController.value.text;
          }
          var res = await FireStore()
              .updateBreeding(_mainController.user.value, breeding);
          Get.back(result: true);
          Get.back(result: true);
          Get.back(result: true);
          if (res != null) {
            Get.snackbar(
              'Success',
              'Berhasil Mengubah Data Pembiakan',
              duration: Duration(seconds: 1),
            );
          }
        } catch (e) {
          Get.back(result: false);
          Get.snackbar(
            'Error',
            e.toString(),
            duration: Duration(seconds: 1),
          );
        }
      } else {
        Get.back(result: false);
        Get.snackbar(
          'Error',
          'Data tidak lengkap',
          duration: Duration(seconds: 1),
        );
      }
    } else {
      if (isNotBlank(_cowModel.value!.id) && selectedSC.value != 0) {
        try {
          var breeding = BreedingModel();
          breeding.breedDate = dateTime.value;
          breeding.cowId = _cowModel.value!.id;
          breeding.id = uuid.v5(
            Uuid.NAMESPACE_URL,
            (_cowModel.value!.id! + uuid.v1()),
          );
          breeding.pregnantState = buntingState.value == 1 ? true : false;
          breeding.sc = buntingState.value == 0 ? 0 : selectedSC.value;
          if (_selectedPejantan.hasValue && _selectedPejantan.value != null) {
            breeding.maleId = _selectedPejantan.value!.uniqueId;
            breeding.maleName = _selectedPejantan.value!.name;
          }
          if (isNotBlank(strowController.value.text)) {
            breeding.strowNumber = strowController.value.text;
          }
          var res = await FireStore()
              .submitBreeding(_mainController.user.value, breeding);
          Get.back(result: true);
          if (res != null) {
            Get.snackbar(
              'Success',
              'Berhasil Menambahkan Data Pembiakan',
              duration: Duration(seconds: 1),
            );
          }
        } catch (e) {
          Get.back(result: false);
          Get.snackbar(
            'Error',
            e.toString(),
            duration: Duration(seconds: 1),
          );
        }
      } else {
        Get.back(result: false);
        Get.snackbar(
          'Error',
          'Data tidak lengkap',
          duration: Duration(seconds: 1),
        );
      }
    }
  }
}
