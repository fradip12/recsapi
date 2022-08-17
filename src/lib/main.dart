import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/routes/routes.dart';
import 'package:src/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recsapi',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      locale: Get.deviceLocale,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      getPages: Routes.routes,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('id', 'ID'), // Indonesia
      ],
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('test'),
    );
  }
}
