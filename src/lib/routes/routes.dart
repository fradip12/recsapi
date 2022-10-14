import 'package:get/get.dart';
import 'package:src/pages/home/home.dart';
import 'package:src/pages/recording/add_sapi.dart';
import 'package:src/pages/sapi/detail_sapi.dart';
import 'package:src/pages/sapi/sapi_saya.dart';
import 'package:src/pages/tambah/pembiakan/pembiakan_detail.dart';
import 'package:src/pages/tambah/pembiakan/tambah_pembiakan.dart';
import 'package:src/pages/tambah/tambah_pages.dart';
import '../main.dart';
import '../pages/tambah/pembiakan/pembiakan.dart';

class Routes {
  Routes._();

  static List<GetPage<dynamic>> routes = [
    ///==========Main==========///
    GetPage(name: '/', page: () => App()),

    ///==========Auth==========///
    ///==========Home==========///
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/sapi', page: () => SapiSaya()),
    GetPage(name: '/sapi-detail', page: () => DetailSapi()),
    GetPage(name: '/add-sapi', page: () => AddSapi()),
    GetPage(name: '/tambah', page:() => TambahPages()),
    GetPage(name: '/tambah-pembiakan', page:() => PembiakanPages()),
    GetPage(name: '/tambah-pembiakan-detail', page:() => PembiakanDetail()),
    GetPage(name: '/tambah-pembiakan-item', page:() => TambahPembiakanPages()),
    ///==========Profile==========///
    ///==========Setting==========///
    ///==========Other==========///
  ];
}
