import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

class SapiSayaController extends GetxController {
  //Var
  final MainController _mainController = Get.find<MainController>();
  final Rx<List<CowModel>> sapiSaya = Rx<List<CowModel>>([]);
  //Function
  
  // @override
  // void onReady() {
  //   super.onReady();
  //    getSapiSaya();
  // }

  void init() async {
    getSapiSaya();
  }

  Future<void> tambahSapi() async {
    // example
    // var dataSapi = CowModel(
    //   birthdate: DateTime.now().toIso8601String(),
    //   bodyLength1Yo: 1.0,
    //   breed: 'rumput',
    //   chestCircumference1Yo: 0.1,
    //   color: 'Green',
    //   gender: 1,
    //   gumbaHeight1Yo: 1,
    //   id: '1',
    //   name: 'bubu',
    //   notes: 'ga ada',
    //   parentF: 'yatim',
    //   parentM: 'yatim',
    //   strowNumber: '1',
    //   weight1Yo: 1,
    //   weight4Mo: 1,
    //   weightBirth: 1,

    // );
    // FireStore().tambahSapi(dataSapi, _mainController.user.value);
    Get.toNamed('/add-sapi');
  }

  getSapiSaya() async {
    var res = await FireStore().getSapi(_mainController.user.value);
    sapiSaya.value.addAll(res);
  }
}
