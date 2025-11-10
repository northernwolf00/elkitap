import 'package:elkitap/core/init/app_initialize.dart';
import 'package:elkitap/core/init/theme_controller.dart';
import 'package:elkitap/core/init/translation_service.dart';
import 'package:elkitap/core/theme/custom_dark_theme.dart';
import 'package:elkitap/core/theme/custom_light_theme.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/views/global_mini_player.dart';

import 'package:elkitap/modules/splash/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationInitialize.initialize();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    String _getLangCode(String langName) {
      switch (langName) {
        case 'English':
          return 'en';
        case 'Русский':
          return 'ru';
        case 'Türkmençe':
        default:
          return 'tr';
      }
    }

    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          builder: (context, child) {
            final themeController = Get.find<ThemeController>();
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: themeController.themeMode == ThemeMode.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
              child: Stack(
                children: [
                  child ?? const SizedBox.shrink(),
                  Obx(() {
                    final miniCtrl = Get.find<GlobalMiniPlayerController>();
                    return Visibility(
                      visible: miniCtrl.isVisible.value,
                      child: Obx(() => Positioned(
                            top: miniCtrl.top.value,
                            left: miniCtrl.left.value,
                            child: const GlobalMiniPlayer(),
                          )),
                    );
                  }),
                ],
              ),
            );
          },
          translations: TranslationService(),
          defaultTransition: Transition.fade,
          // fallbackLocale: const Locale('tr'),
          debugShowCheckedModeBanner: false,
          locale: Locale(
            _getLangCode(storage.read('selectedLanguage') ?? 'Türkmençe'),
          ),
          fallbackLocale: const Locale('tr', 'TR'),
          theme: CustomLightTheme().themeData,
          darkTheme: CustomDarkTheme().themeData,
          themeMode: Get.find<ThemeController>().themeMode,
          home: SplashPageWidget(),
        );
      },
    );
  }
}
