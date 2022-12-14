import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/model/summary_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find<MainController>();
  final _summary = BehaviorSubject<SummaryModel?>.seeded(null);
  Stream<SummaryModel?> get summary => _summary.stream;
  final List<String> myProducts = [
    'Induk',
    'Pejantan',
    'Anak Jantan',
    'Anak Betina',
  ].obs;
  final List<String> total = ['Sapi', 'Produksi Susu'].obs;
  final List<HomeMenu> myMenu = [
    HomeMenu(
      title: 'Sapi Saya',
      route: '/sapi',
      icon: "asset/images/logo/new-sapi.svg",
    ),
    HomeMenu(
      title: 'Recording',
      route: '/tambah',
      icon: "asset/images/logo/new-recording.svg",
    ),
    HomeMenu(
      title: 'Unduh Data',
      route: '/lihat',
      icon: "asset/images/logo/new-unduh.svg",
    ),
    HomeMenu(
      title: 'Profil',
      route: '/',
      icon: "asset/images/logo/new-profile.svg",
    ),
  ].obs;

  /// Put All logic on controller

  @override
  void onInit() {
    super.onInit();
    refreshPages();
  }

  Future<void> refreshPages() async {
    getSummary();
  }

  /// Function
  ///
  Future<void> getSummary() async {
    var res = await FireStore().getSummary(mainController.user.value);
    _summary.add(res);
  }
}
