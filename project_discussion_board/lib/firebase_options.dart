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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC0kon8-tbLaRhWrYSsnIgEXaYRWF4PDFA',
    appId: '1:954946793574:web:f1d80aa0ac16c5fe817da7',
    messagingSenderId: '954946793574',
    projectId: 'discussionboarddatabase',
    authDomain: 'discussionboarddatabase.firebaseapp.com',
    storageBucket: 'discussionboarddatabase.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtPAtu1oZmkVnvmJtDcela-7DchtXEiTQ',
    appId: '1:954946793574:android:05b2cc8d093193a2817da7',
    messagingSenderId: '954946793574',
    projectId: 'discussionboarddatabase',
    storageBucket: 'discussionboarddatabase.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgBCfGcrDZWdN28Hk7tz681jQeh8NuS-g',
    appId: '1:954946793574:ios:745b256a37ee208c817da7',
    messagingSenderId: '954946793574',
    projectId: 'discussionboarddatabase',
    storageBucket: 'discussionboarddatabase.firebasestorage.app',
    iosBundleId: 'com.example.projectDiscussionBoard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgBCfGcrDZWdN28Hk7tz681jQeh8NuS-g',
    appId: '1:954946793574:ios:745b256a37ee208c817da7',
    messagingSenderId: '954946793574',
    projectId: 'discussionboarddatabase',
    storageBucket: 'discussionboarddatabase.firebasestorage.app',
    iosBundleId: 'com.example.projectDiscussionBoard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC0kon8-tbLaRhWrYSsnIgEXaYRWF4PDFA',
    appId: '1:954946793574:web:f9238c527b6089bf817da7',
    messagingSenderId: '954946793574',
    projectId: 'discussionboarddatabase',
    authDomain: 'discussionboarddatabase.firebaseapp.com',
    storageBucket: 'discussionboarddatabase.firebasestorage.app',
  );
}