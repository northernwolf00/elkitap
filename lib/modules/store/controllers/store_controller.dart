import 'package:get/get.dart';

class BookDetailController extends GetxController {
  var isAudio = false.obs;
  
  void toggleToText() {
    isAudio.value = false;
  }
  
  void toggleToAudio() {
    isAudio.value = true;
  }
}