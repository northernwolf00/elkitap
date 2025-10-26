import 'package:get/get.dart';

class BookDetailController extends GetxController {
  var isAudio = false.obs;
    var isAddedToWantToRead = false.obs;
    var selectedLanguage = 'English'.obs;
  
  void toggleToText() {
    isAudio.value = false;
  }
  
  void toggleToAudio() {
    isAudio.value = true;
  }
   void toggleAddToWantToRead() {
    isAddedToWantToRead.value = !isAddedToWantToRead.value;
  }
   void setLanguage(String language) {
    selectedLanguage.value = language;
  }
}