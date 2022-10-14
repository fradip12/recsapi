import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

class PembiakanController extends GetxController {

  final MainController _mainController = Get.find<MainController>();
  final _listSapiBeti = BehaviorSubject<List<CowModel>>.seeded([]);
  Sink<List<CowModel>> get _inListSapiBeti => _listSapiBeti.sink;
  Stream<List<CowModel>> get outListSapiBeti => _listSapiBeti.stream;

  @override
  void onInit() async {
    super.onInit();
    var res = await FireStore().getSapiF(_mainController.user.value);
    Logger().wtf(res);
    _listSapiBeti.add(res);
  }
}