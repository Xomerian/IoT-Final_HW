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
    apiKey: 'AIzaSyB_KyNb2knY2vb2yqa2Im9xaUBmugx3eVg',
    appId: '1:1048965530735:web:b1131ea12541bfce8d799a',
    messagingSenderId: '1048965530735',
    projectId: 'lab-6-7233f',
    authDomain: 'lab-6-7233f.firebaseapp.com',
    storageBucket: 'lab-6-7233f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD30AvE6qLEYyi2VwKapmZmwA7sO-pz2SQ',
    appId: '1:1048965530735:android:8054c57f45f2df758d799a',
    messagingSenderId: '1048965530735',
    projectId: 'lab-6-7233f',
    storageBucket: 'lab-6-7233f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQHgwNdA4uzx0_bxuT7PxcXlidNFs4Tvs',
    appId: '1:1048965530735:ios:131db395087c126f8d799a',
    messagingSenderId: '1048965530735',
    projectId: 'lab-6-7233f',
    storageBucket: 'lab-6-7233f.appspot.com',
    iosClientId: '1048965530735-91sqepjgflnv3rsudm4u1kt3ki6c8qtj.apps.googleusercontent.com',
    iosBundleId: 'com.example.iotL6',
  );
}