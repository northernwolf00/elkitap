import 'package:get/get.dart';

class EpubController extends GetxController {
  // Track current page and total pages
  var currentPage = 0.obs;
  var totalPages = 0.obs;

  // Track whether we reached the last page
  var isAtLastPage = false.obs;

  void onPageFlip(int current, int total) {
    currentPage.value = current;
    totalPages.value = total;
  }

  void onLastPage(int index) {
    isAtLastPage.value = true;
  }
}
