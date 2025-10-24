import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/modules/genre/view/books_grid_screen_View.dart';
import 'package:elkitap/modules/genre/view/genrs_page_view.dart';
import 'package:elkitap/modules/library/views/notes_view.dart';
import 'package:elkitap/modules/library/views/reading_list_view.dart';
import 'package:elkitap/modules/profile/views/profile_view.dart';
import 'package:elkitap/modules/splash/views/splash_view.dart';
import 'package:elkitap/modules/store/views/all_geners_view.dart';
import 'package:elkitap/modules/store/views/author_view.dart';
import 'package:elkitap/modules/store/views/profesional_readers_profil.dart';
import 'package:elkitap/modules/store/views/profesionals_read_view.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => SplashPageWidget()),
    GetPage(name: Routes.BOTTOMNAV, page: () => const BottomNavScreen()),
    GetPage(name: Routes.PROFILE, page: () => const ProfileScreen()),
    GetPage(name: Routes.WANTREAD, page: () => const ReadingListScreen()),
    GetPage(name: Routes.NOTES, page: () => const NotesScreen()),
    GetPage(name: Routes.BOOK_DETAIL, page: () => const BookDetailView()),
    GetPage(name: Routes.AUTHOR_DETAIL, page: () => const BookAuthorView()),
    GetPage(name: Routes.ALL_GENRES, page: () => const AllGenresView()),
    GetPage(
      name: Routes.PROFESSIONALS_READ,
      page: () => const ProfessionalsReadView(),
    ),
    GetPage(
      name: Routes.STORE_DETAIL,
      page: () => const ProfesionalReadersProfil(),
    ),
    GetPage(
      name: Routes.GENRS_DETAIL,
      page: () => const GenrsDetailViewScreen(),
    ),
    GetPage(name: Routes.GENRS_LIST, page: () => BooksGridScreen()),
  ];
}
