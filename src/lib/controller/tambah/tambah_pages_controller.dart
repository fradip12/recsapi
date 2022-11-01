import 'package:get/get.dart';

import '../../common/arguments/arguments.dart';

class TambahPagesController extends GetxController {

   final List<HomeMenu> myMenu = [
    HomeMenu(
      title: 'Pembiakan',
      route: '/tambah-pembiakan',
      icon: "asset/images/logo/new-pembiakan.svg",
    ),
    HomeMenu(
      title: 'Produksi Susu',
      route: '/susu',
      icon: "asset/images/logo/new-susu.svg",
    ),
    HomeMenu(
      title: 'Pakan',
      route: '/',
      icon: "asset/images/logo/new-pakan.svg",
    ),
    HomeMenu(
      title: 'Kesehatan',
      route: '/',
      icon: "asset/images/logo/new-kesehatan.svg",
    ),
  ].obs;

  void init() async {

  }
}