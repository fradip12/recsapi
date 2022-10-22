import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/model/birth_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

import '../../../common/model/breeding_model.dart';
import '../../../common/model/sapi_model.dart';

class KelahiranController extends GetxController {
  final MainController _mainController = Get.find<MainController>();
  late KelahiranPagesArguments args;

  final _breedModel = BehaviorSubject<BreedingModel?>();
  Sink<BreedingModel?> get breedModel => _breedModel.sink;
  Stream<BreedingModel?> get breedModelStream => _breedModel.stream;

  final _cowModel = BehaviorSubject<CowModel?>();
  Stream<CowModel?> get cowModelStream => _cowModel.stream;

  final _birthModel = BehaviorSubject<List<BirthModel>?>();
  Sink<List<BirthModel>?> get birthModel => _birthModel.sink;
  Stream<List<BirthModel>?> get birthModelStream => _birthModel.stream;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments as KelahiranPagesArguments;
    _breedModel.add(args.breedData);
    init();
  }

  void init() async {
    getDetailSapi();
    getBirthList();
  }

  Future<void> getDetailSapi() async {
    if (isNotBlank(_breedModel.value?.cowId)) {
      var res = await FireStore()
          .getDetailSapi(_mainController.user.value, _breedModel.value!.cowId);
      _cowModel.add(res);
    }
  }

  Future<void> getBirthList() async {
    if (isNotBlank(_breedModel.value?.id)) {
      var res = await FireStore()
          .getListBirth(_mainController.user.value, _breedModel.value!.id!);
      _birthModel.add(res);
    }
  }
}
