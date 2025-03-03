// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_R9L8sbCpqdOggYsexNI1PJXQBIi_C4Q',
    appId: '1:875597949974:web:e5bad3f2a11a1016951937',
    messagingSenderId: '875597949974',
    projectId: 'trademate-d27ec',
    authDomain: 'trademate-d27ec.firebaseapp.com',
    storageBucket: 'trademate-d27ec.firebasestorage.app',
    measurementId: 'G-WBWL2ZKE1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAy_itFgH3CJrFrwFI3YIRL7JDBMYXBIfs',
    appId: '1:875597949974:android:68fbcbd407085260951937',
    messagingSenderId: '875597949974',
    projectId: 'trademate-d27ec',
    storageBucket: 'trademate-d27ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBclElXDeMI0o3hwS2bIc1TdZ-JsOSrfu4',
    appId: '1:875597949974:ios:4a094f754744b559951937',
    messagingSenderId: '875597949974',
    projectId: 'trademate-d27ec',
    storageBucket: 'trademate-d27ec.firebasestorage.app',
    iosBundleId: 'com.example.ios',
  );
}
