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

  final _searchListener = BehaviorSubject<String?>.seeded(null);
  Stream<String?> get searchListenerStream => _searchListener.stream;
  Sink<String?> get searchListenerSink => _searchListener.sink;

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  void init() async {
    var res = await FireStore().getSapiF(
      _mainController.user.value,
      keywords: _searchListener.value,
    );
    Logger().wtf(res);
    _listSapiBeti.add(res);
  }
}
