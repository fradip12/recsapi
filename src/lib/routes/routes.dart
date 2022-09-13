import 'package:get/get.dart';
import 'package:src/pages/home/home.dart';
import 'package:src/pages/recording/add_recording.dart';
import 'package:src/pages/sapi/detail_sapi.dart';
import 'package:src/pages/sapi/sapi_saya.dart';
import '../main.dart';

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
    GetPage(name: '/add-record', page: () => AddRecording()),

    ///==========Profile==========///
    ///==========Setting==========///
    ///==========Other==========///
  ];
}
