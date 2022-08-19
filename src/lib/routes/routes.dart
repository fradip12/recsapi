import 'package:get/get.dart';
import 'package:src/pages/home/home.dart';
import '../main.dart';

class Routes {
  Routes._();

  static List<GetPage<dynamic>> routes = [
    ///==========Main==========///
    GetPage(name: '/', page: () => App()),

    ///==========Auth==========///
    ///==========Home==========///
    GetPage(name: '/home', page: () => Home()),
    ///==========Profile==========///
    ///==========Setting==========///
    ///==========Other==========///
  ];
}
