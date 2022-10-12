// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBKyLOWaOao_Pg0N2y4ij2kaFYTLaRPTrA',
    appId: '1:1067733042753:web:b966f48a1d48c8263e28c0',
    messagingSenderId: '1067733042753',
    projectId: 'cofee-flutter',
    authDomain: 'cofee-flutter.firebaseapp.com',
    storageBucket: 'cofee-flutter.appspot.com',
    measurementId: 'G-S2HJ448SBM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdc8geAUnmzyRwZSCHU02LDgvr-DCW1C0',
    appId: '1:1067733042753:android:19d60cbd82e95b8b3e28c0',
    messagingSenderId: '1067733042753',
    projectId: 'cofee-flutter',
    storageBucket: 'cofee-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOjGUv-RMZrIbfBlNfjH7vtv2qCvRyKjQ',
    appId: '1:1067733042753:ios:fa1839faf50e77763e28c0',
    messagingSenderId: '1067733042753',
    projectId: 'cofee-flutter',
    storageBucket: 'cofee-flutter.appspot.com',
    iosClientId: '1067733042753-jpufgou9299tf3682bqs37u65pptqdbp.apps.googleusercontent.com',
    iosBundleId: 'com.example.coffeFlutter',
  );
}