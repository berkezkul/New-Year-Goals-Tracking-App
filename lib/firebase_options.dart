import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTG_Cp-JxT12J3PhA1OyxqBrAZfxlfg44',
    appId: '1:693253024986:android:ed05e7cdf1d197a172c9e3',
    messagingSenderId: '693253024986',
    projectId: 'new-year-goals-app',
    storageBucket: 'new-year-goals-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR-IOS-API-KEY',
    appId: 'YOUR-IOS-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'new-year-goals-app',
    storageBucket: 'new-year-goals-app.appspot.com',
    iosClientId: 'YOUR-IOS-CLIENT-ID',
    iosBundleId: 'com.newyeargoal.berkeozkul.newYearGoalsApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: 'AIzaSyDTG_Cp-JxT12J3PhA1OyxqBrAZfxlfg44',
      appId: '1:693253024986:web:YOUR_WEB_APP_ID',
      messagingSenderId: '693253024986',
      projectId: 'new-year-goals-app',
      authDomain: 'new-year-goals-app.firebaseapp.com',
      storageBucket: 'new-year-goals-app.firebasestorage.app');
}
