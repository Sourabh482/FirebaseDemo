import 'package:demo_application/src/global/deep_linking.dart';
import 'package:demo_application/src/global/fireabse_services/firebase_messaging_service.dart';
import 'package:demo_application/src/global/fireabse_services/firebase_options.dart';
import 'package:demo_application/src/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'src/global/fireabse_services/firebase_dynamic_links.dart';

late String data;
const _kShouldTestAsyncErrorOnInit = false;
// Toggle this for testing Crashlytics in your app locally.
const kTestingCrashlytics = true;

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// To set bottom navigation bar color and Status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.deepPurple));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    } catch (e) {}
    runApp(const MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      enableLog: true,
      textDirection: TextDirection.ltr,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onReady: () async {
        await Get.putAsync(() => FireBaseMessagingService().init());
        await Get.putAsync(() => FirebaseDynamic().init());
        getLandingDependencies();
      },
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
