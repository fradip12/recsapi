import 'package:firebase_core/firebase_core.dart';

class InitHelper {
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    print(firebaseApp);
    return firebaseApp;
  }
}
