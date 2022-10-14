import 'package:get/get.dart';

import '../../common/arguments/arguments.dart';

class TambahPagesController extends GetxController {

   final List<HomeMenu> myMenu = [
    HomeMenu(
      title: 'Pembiakan',
      route: '/tambah-pembiakan',
      icon: "asset/images/logo/Group 33.png",
    ),
    HomeMenu(
      title: 'Produksi Susu',
      route: '/',
      icon: "asset/images/logo/icon-park_milk.png",
    ),
    HomeMenu(
      title: 'Pakan',
      route: '/',
      icon: "asset/images/logo/mdi_grass.png",
    ),
    HomeMenu(
      title: 'Kesehatan',
      route: '/',
      icon: "asset/images/logo/account.png",
    ),
  ].obs;

  void init() async {

  }
}