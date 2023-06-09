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
        return macos;
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
    apiKey: 'AIzaSyB6p89SBRlT05VXcCDU-qJq7v_Mb4FpYWQ',
    appId: '1:545660385810:web:1940f73c3ccf0d281cb6cb',
    messagingSenderId: '545660385810',
    projectId: 'orderuytin',
    databaseURL:
        'https://orderuytin-default-rtdb.asia-southeast1.firebasedatabase.app',
    authDomain: 'orderuytin.firebaseapp.com',
    storageBucket: 'orderuytin.appspot.com',
    measurementId: 'G-6WD70QTTYN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_R8dOX6LZVdtK8pu6AQmBgR9LvXekrWw',
    appId: '1:545660385810:android:b24626423b555af51cb6cb',
    messagingSenderId: '545660385810',
    projectId: 'orderuytin',
    databaseURL:
        'https://orderuytin-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orderuytin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvdcwGYcj7oBjc4GjqdHlwp3XJqxT1bUA',
    appId: '1:545660385810:ios:1f836ce0ee9d34db1cb6cb',
    messagingSenderId: '545660385810',
    projectId: 'orderuytin',
    databaseURL:
        'https://orderuytin-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orderuytin.appspot.com',
    iosClientId:
        '545660385810-7bsoapc3i714go9sg9ch66k4o5c3kt9v.apps.googleusercontent.com',
    iosBundleId: 'com.example.orderuytinmobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvdcwGYcj7oBjc4GjqdHlwp3XJqxT1bUA',
    appId: '1:545660385810:ios:1f836ce0ee9d34db1cb6cb',
    messagingSenderId: '545660385810',
    projectId: 'orderuytin',
    databaseURL:
        'https://orderuytin-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orderuytin.appspot.com',
    iosClientId:
        '545660385810-7bsoapc3i714go9sg9ch66k4o5c3kt9v.apps.googleusercontent.com',
    iosBundleId: 'com.example.orderuytinmobile',
  );
}
