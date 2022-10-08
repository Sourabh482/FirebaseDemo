import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class ScreenOneController extends GetxController{
  late Future<void> _initializeFlutterFireFuture;

  Future<void> _initializeFlutterFire() async {
    if (kTestingCrashlytics) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }
}