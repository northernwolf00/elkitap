import 'dart:async';

// import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:elkitap/modules/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


@immutable
final class ApplicationInitialize {
  const ApplicationInitialize._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      // Logger().e(error.toString());
    });
  }

  static Future<void> _initialize() async {
    try {
      Get.put(AuthController());
      // await GetStorage.init();
      // Get.put(AuthStorage());
      // Get.put(ThemeController());
      // Get.put(HomeController());
      // Get.put(SearchControllerMine());
      // Get.put(UserProfilController());
      // Get.put(FavoritesController());
      // Get.put(ChatController());

      // await Get.putAsync(() => ChatService().init());

      // Get.put(AddHouseController(), permanent: true);
      // Get.put(EditHouseController(), permanent: true);
      // Get.find<AddHouseController>().fetchInitialData();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
     
      // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      // final localNotificationsService = LocalNotificationsService.instance();
      // await localNotificationsService.init();
      // final firebaseMessagingService = FirebaseMessagingService.instance();
      // await firebaseMessagingService.init(localNotificationsService: localNotificationsService);
      // await FirebaseMessaging.instance.subscribeToTopic('EVENT');
    } catch (e) {}
  }
}
