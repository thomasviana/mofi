// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_uat.dart';
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAP_k5dSb2dXXCH7Xek4iCglP2RMZi9pOA',
    appId: '1:1087922621257:web:b1fbbf41f0ddb5b2006898',
    messagingSenderId: '1087922621257',
    projectId: 'mofi-flutter-uat-ad6b8',
    authDomain: 'mofi-flutter-uat-ad6b8.firebaseapp.com',
    storageBucket: 'mofi-flutter-uat-ad6b8.appspot.com',
    measurementId: 'G-EX8FQ2CHTZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJu8HHRE6B80-Ni5rwcJ-nAxraVfGU8bY',
    appId: '1:1087922621257:android:68cb90cb087705ae006898',
    messagingSenderId: '1087922621257',
    projectId: 'mofi-flutter-uat-ad6b8',
    storageBucket: 'mofi-flutter-uat-ad6b8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsXxeI4G41jt0spVlEfPAyMR1jR0Lg00A',
    appId: '1:1087922621257:ios:1b3e3017641a6984006898',
    messagingSenderId: '1087922621257',
    projectId: 'mofi-flutter-uat-ad6b8',
    storageBucket: 'mofi-flutter-uat-ad6b8.appspot.com',
    iosClientId:
        '1087922621257-8jo9ghf97tni27m33ve4t1ro7g0cphbc.apps.googleusercontent.com',
    iosBundleId: 'com.thomasviana.mofi.uat',
  );
}