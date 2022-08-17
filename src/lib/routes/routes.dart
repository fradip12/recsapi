import 'package:get/get.dart';
import '../main.dart';

class Routes {
  Routes._();

  static List<GetPage<dynamic>> routes = [
    ///==========Main==========///
    GetPage(name: '/', page: () => App()),

    ///==========Auth==========///
    ///==========Home==========///
    ///==========Profile==========///
    ///==========Setting==========///
    ///==========Other==========///
  ];
}
