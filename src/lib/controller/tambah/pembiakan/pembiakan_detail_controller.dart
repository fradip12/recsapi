import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/model/breeding_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

import '../../../common/arguments/arguments.dart';
import '../../../common/model/sapi_model.dart';

class PembiakanDetailController extends GetxController {
  final MainController _mainController = Get.find<MainController>();
  late PembiakanDetailArguments args;

  final _breeding = BehaviorSubject<List<BreedingModel>?>.seeded(null);
  Sink<List<BreedingModel>?> get inBreeding => _breeding.sink;
  Stream<List<BreedingModel>?> get outBreeding => _breeding.stream.delay(Duration(seconds: 2));

  final _cowModel = BehaviorSubject<CowModel?>.seeded(null);
  Sink<CowModel?> get inCowModel => _cowModel.sink;
  Stream<CowModel?> get outCowModel => _cowModel.stream;


  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      args = Get.arguments;
    }
    Logger().w(args.cowId);
    getBreedingList();
    getDetailSapi();
  }

  Future<void> getBreedingList() async {
    var res =
        await FireStore().getBreeding(_mainController.user.value, args.cowId);
    _breeding.add(res);
    Logger().wtf(res);
  }

  Future<void> getDetailSapi() async {
    await Future.delayed(Duration(seconds: 2));
    var res =
        await FireStore().getDetailSapi(_mainController.user.value, args.cowId);
    _cowModel.add(res);

    Logger().wtf(res);
  }
}
