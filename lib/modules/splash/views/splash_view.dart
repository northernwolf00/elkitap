import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

// class SplashPageWidget extends StatelessWidget {
//   SplashPageWidget({Key? key}) : super(key: key);

//   final SplashController controller = Get.put(SplashController());

//   @override
//   Widget build(BuildContext context) {
//     // Delay and navigate to main screen
//     Future.delayed(const Duration(seconds: 4), () {
//       Get.off(() => BottomNavScreen());
//     });

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Theme.of(context).colorScheme.background,
//         child: Center(
//           child: Lottie.asset(
//             'assets/animations/elkitap_screen.json',
//             width: 200,
//             height: 200,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }

class SplashPageWidget extends StatelessWidget {
  SplashPageWidget({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    controller.initializeVideo();
    Future.delayed(const Duration(seconds: 4), () async {
      Get.off(() => BottomNavScreen());
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Theme.of(context).colorScheme.background,
            //     Theme.of(context).colorScheme.secondary,
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            ),
        child: Obx(() {
          if (controller.isVideoInitialized.value &&
              !controller.videoFailed.value) {
            return AnimatedOpacity(
              opacity: controller.isVideoPlaying.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.videoController.value.size.width,
                  height: controller.videoController.value.size.height,
                  child: VideoPlayer(controller.videoController),
                ),
              ),
            );
          } else if (controller.videoFailed.value) {
            return Center(child: Lottie.asset('assets/animations/elkitap.json'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator(strokeWidth: 3)],
              ),
            );
          }
        }),
      ),
    );
  }
}
