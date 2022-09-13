import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/model/sapi_model.dart';

class DetailSapiController extends GetxController {
  /// Variable
  ///
  late DetailSapiArguments args;
  late Rx<CowModel> cow = Rx<CowModel>(CowModel());

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      args = Get.arguments;
      cow.value = args.sapi!;
    }
  }
}
