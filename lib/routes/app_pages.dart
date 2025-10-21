import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';


import 'app_routes.dart';
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.BOTTOMNAV,
      page: () => const BottomNavScreen(),
    ),
  ];
}
