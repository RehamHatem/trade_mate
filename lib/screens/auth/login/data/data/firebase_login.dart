import 'package:firebase_auth/firebase_auth.dart';
import 'package:trade_mate/remote/fire_base_functions.dart';
import 'package:trade_mate/utils/shared_preference.dart';

class FirebaseLogin{


   login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await SharedPreference.init();
     var shared = SharedPreference.saveData(key: "email", value: email);
      // if (credential.user!.emailVerified) {

      // }
      // else {onError("please verify your account");}
    } on FirebaseAuthException catch (e) {
      throw(e.code);
    }
  }
}