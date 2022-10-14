import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/controller/main_controller.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find<MainController>();
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
      icon: "asset/images/logo/logo.png",
    ),
    HomeMenu(
      title: 'Tambah Recording',
      route: '/tambah',
      icon: "asset/images/logo/add-one.png",
    ),
    HomeMenu(
      title: 'Lihat Recording',
      route: '/',
      icon: "asset/images/logo/notebook.png",
    ),
    HomeMenu(
      title: 'Profile',
      route: '/',
      icon: "asset/images/logo/account.png",
    ),
  ].obs;

  /// Put All logic on controller

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /// Function

}
