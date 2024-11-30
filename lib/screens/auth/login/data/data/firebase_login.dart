import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin{
   login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user!.emailVerified) {

      // }
      // else {onError("please verify your account");}
    } on FirebaseAuthException catch (e) {
      throw(e.code);
    }
  }
}