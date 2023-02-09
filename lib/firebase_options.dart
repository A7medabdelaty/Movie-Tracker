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
    apiKey: 'AIzaSyD9so5EZQTe59llgKGquasfQmBWAYrXWs8',
    appId: '1:569101457121:web:6a61811c53476557db89a0',
    messagingSenderId: '569101457121',
    projectId: 'movie-app-df12d',
    authDomain: 'movie-app-df12d.firebaseapp.com',
    storageBucket: 'movie-app-df12d.appspot.com',
    measurementId: 'G-BG14WXKMKY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgPM4a7sUYIa80RLOYXqBamHvlf4rA65o',
    appId: '1:569101457121:android:37062153711ce36fdb89a0',
    messagingSenderId: '569101457121',
    projectId: 'movie-app-df12d',
    storageBucket: 'movie-app-df12d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYbB981U-GN5qPa4Viw7OwPZGn6hyQ9dA',
    appId: '1:569101457121:ios:060a4833e3acf76bdb89a0',
    messagingSenderId: '569101457121',
    projectId: 'movie-app-df12d',
    storageBucket: 'movie-app-df12d.appspot.com',
    iosClientId: '569101457121-rk3hr9di591fje7pf476p6pf38f3724u.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviesApp',
  );
}