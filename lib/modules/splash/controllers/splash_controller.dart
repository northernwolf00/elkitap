import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  var isVideoInitialized = false.obs;
  var videoFailed = false.obs;
  var isVideoPlaying = false.obs;

  late VideoPlayerController videoController;

  Future<void> initializeVideo() async {
    try {
      videoController =
          VideoPlayerController.asset('assets/videos/splash.mp4');
      await videoController.setLooping(true);
      await videoController.initialize();

      isVideoInitialized.value = true;
      await videoController.play();
      isVideoPlaying.value = true;
    } catch (e) {
     
      videoFailed.value = true;
      isVideoInitialized.value = true;
    }
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
