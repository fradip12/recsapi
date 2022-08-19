import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/helper/initialize.dart';
import 'package:src/common/widget/keyboard_dismiss.dart';
import 'package:src/pages/auth/sign_in.dart';
import 'package:src/routes/routes.dart';
import 'package:src/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      getPages: Routes.routes,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('id', 'ID'), // Indonesia
      ],
      home: App(),
    );
  }
}

// Put Provider here if any
// Check Session here ( Login/ Not Logged In )
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOntap(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: FutureBuilder(
              future: InitHelper().initializeFirebase(),
              builder: (context, builder) {
                if (builder.connectionState == ConnectionState.done) {
                  return SignIn();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
