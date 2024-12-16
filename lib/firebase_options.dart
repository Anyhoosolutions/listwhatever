// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWpLyIJVirkLJj1QNfAcZoWyyXDuaXVsY',
    appId: '1:386438315822:web:f9f8ce77620dfde16284bf',
    messagingSenderId: '386438315822',
    projectId: 'listwhatever-ad43ed',
    authDomain: 'listwhatever-ad43ed.firebaseapp.com',
    storageBucket: 'listwhatever-ad43ed.appspot.com',
    measurementId: 'G-EK5P3415VY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9hR4vr5zUYH4c_MJr-c2ZCrZo95H2eBI',
    appId: '1:386438315822:android:3c40734d8299548d6284bf',
    messagingSenderId: '386438315822',
    projectId: 'listwhatever-ad43ed',
    storageBucket: 'listwhatever-ad43ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-qJRPNH4hHSweO0xt_dru0R-WNdJnV7k',
    appId: '1:386438315822:ios:a7020f6f605741436284bf',
    messagingSenderId: '386438315822',
    projectId: 'listwhatever-ad43ed',
    storageBucket: 'listwhatever-ad43ed.appspot.com',
    androidClientId: '386438315822-2sjo9r4u9f7sb8vu9je36980il6ujgbd.apps.googleusercontent.com',
    iosClientId: '386438315822-k20vocmi631a8d0oal5c5h2ecfvm7o5o.apps.googleusercontent.com',
    iosBundleId: 'com.example.listwhatever',
  );
}
