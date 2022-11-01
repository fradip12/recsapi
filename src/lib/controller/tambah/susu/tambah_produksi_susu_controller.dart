import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/milk_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';
import 'package:uuid/uuid.dart';

class TambahProduksiSusuController extends GetxController {
  final MainController _mainController = Get.find<MainController>();
  late TambahProduksiSusuArguments? args;
  Rx<TextEditingController> namaSapiController = TextEditingController().obs;
  Rx<TextEditingController> kodeSapiController = TextEditingController().obs;
  Rx<TextEditingController> laktasiController = TextEditingController().obs;
  Rx<TextEditingController> hariProduksiSusu = TextEditingController().obs;
  Rx<TextEditingController> susuPagiController = TextEditingController().obs;
  Rx<TextEditingController> susuSoreController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      args = Get.arguments as TambahProduksiSusuArguments;
      namaSapiController.value.text = args!.cowData.name!;
      kodeSapiController.value.text = args!.cowData.uniqueId!;
    }

    if (args != null && args?.editData != null) {
      namaSapiController = TextEditingController(text: args!.cowData.name).obs;
      kodeSapiController =
          TextEditingController(text: args!.cowData.uniqueId).obs;
      laktasiController =
          TextEditingController(text: (args!.editData?.nBirth ?? 0).toString()).obs;
      hariProduksiSusu =
          TextEditingController(text: (args!.editData?.nDay ?? 0).toString()).obs;
      susuPagiController =
          TextEditingController(text: (args!.editData?.morningMilk ?? 0).toString())
              .obs;
      susuSoreController =
          TextEditingController(text: (args!.editData?.afternoonMilk ?? 0).toString())
              .obs;
    }
  }

  Future<void> simpanData() async {
    bool isEdit = args?.editData != null;

    if (!isEdit) {
      var uuid = Uuid();
      var data = MilkModel();
      data.id =
          uuid.v5(Uuid.NAMESPACE_URL, (args!.cowData.id! + args!.selectedDay));
      data.cowId = args!.cowData.id!;
      data.nBirth = int.parse(laktasiController.value.text);
      data.date = args?.selectedDay;
      data.nDay = int.parse(hariProduksiSusu.value.text);
      if (isNotBlank(susuPagiController.value.text)) {
        data.morningMilk = int.parse(susuPagiController.value.text);
      }
      if (isNotBlank(susuSoreController.value.text)) {
        data.afternoonMilk = int.parse(susuSoreController.value.text);
      }

      try {
        Logger().wtf(data.toJson());
        var res =
            await FireStore().submitMilk(_mainController.user.value, data);

        if (res != null) {
          Get.back(result: true);
          Get.snackbar('Success', 'Berhasil Menambahkan Data');
        }
      } catch (e) {
        Get.back(result: false);
        Get.snackbar('Error', e.toString());
      }
    } else {
      var data = MilkModel();
      data.id = args!.editData!.id;
      data.cowId = args!.cowData.id!;
      data.nBirth = int.parse(laktasiController.value.text);
      data.date = args?.editData?.date;
      data.nDay = int.parse(hariProduksiSusu.value.text);
      if (isNotBlank(susuPagiController.value.text)) {
        data.morningMilk = int.parse(susuPagiController.value.text);
      }
      if (isNotBlank(susuSoreController.value.text)) {
        data.afternoonMilk = int.parse(susuSoreController.value.text);
      }

      try {
        Logger().wtf(data.toJson());
        var res =
            await FireStore().updateMilk(_mainController.user.value, data);

        if (res != null) {
          Get.back(result: true);
          Get.snackbar('Success', 'Berhasil Menambahkan Data');
        }
      } catch (e) {
        Get.back(result: false);
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
