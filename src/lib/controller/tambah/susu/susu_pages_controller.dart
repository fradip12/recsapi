import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';

import '../../../common/model/sapi_model.dart';
import '../../../common/services/firebase_auth.dart';
import '../../main_controller.dart';

class SusuPagesController extends GetxController {
  final MainController _mainController = Get.find<MainController>();

  final _listSapiBeti = BehaviorSubject<List<CowModel>>.seeded([]);
  Sink<List<CowModel>> get _inListSapiBeti => _listSapiBeti.sink;
  Stream<List<CowModel>> get outListSapiBeti => _listSapiBeti.stream;

  @override
  void onInit() {
    super.onInit();
    getSapiBetina();
  }

  Future<void> getSapiBetina() async {
    var res = await FireStore().getSapiF(_mainController.user.value);
    Logger().wtf(res);
    _listSapiBeti.add(res);
  }
}
