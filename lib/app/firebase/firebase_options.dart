// File generated by FlutterFire CLI.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC8Q0z7scHYEkwXsgKsCrUP1wUt3Di2HQ8',
    appId: '1:658828835070:web:6594672af988aa72150daf',
    messagingSenderId: '658828835070',
    projectId: 'flutterbase7',
    authDomain: 'flutterbase7.firebaseapp.com',
    storageBucket: 'flutterbase7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjtuldXFULi-2MVxxni0-4zJdVUyoWdyE',
    appId: '1:658828835070:android:0bcd6185da90a1bd150daf',
    messagingSenderId: '658828835070',
    projectId: 'flutterbase7',
    storageBucket: 'flutterbase7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKRhQw8keAKAytYeNYctAoLwiWB_TThUA',
    appId: '1:658828835070:ios:789a818edebeee2e150daf',
    messagingSenderId: '658828835070',
    projectId: 'flutterbase7',
    storageBucket: 'flutterbase7.appspot.com',
    androidClientId: '658828835070-07rj049n2npd161jn5ihpksotgc094ii.apps.googleusercontent.com',
    iosClientId: '658828835070-smau1li0irtvboulqts6qci3etvupg8i.apps.googleusercontent.com',
    iosBundleId: 'com.anywhostudios.flutterbase',
  );
}