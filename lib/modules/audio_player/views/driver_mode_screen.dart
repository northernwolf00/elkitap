import 'dart:ui';

import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverModeScreen extends StatelessWidget {
  const DriverModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioPlayerController>();

    return Scaffold(
        body: Stack(children: [
      // Background Image
      Positioned.fill(
        child: Image.asset(
          'assets/images/b6.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF8B5A3C),
            );
          },
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade900.withOpacity(0.7),
                  Colors.grey.shade800.withOpacity(0.75),
                  Colors.grey.shade900.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
      ),
      SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.disableDriverMode();
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Book Cover - Large
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/b6.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade800,
                                  child: Center(
                                    child: Icon(
                                      Icons.book,
                                      size: 80,
                                      color: Colors.white30,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: GestureDetector(
                              onTap: () => controller.playPause(),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CustomIcon(
                                    title: controller.isPlaying.value
                                        ? 'assets/icons/a4.svg'
                                        : 'assets/icons/a3.svg',
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Time Display - Extra Large
                  Obx(() {
                    return Text(
                      controller.formatDuration(controller.position.value),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),

                  Obx(() {
                    final duration = controller.duration.value;
                    final position = controller.position.value;

                    final durationSeconds = duration.inSeconds.toDouble();
                    // Clamp the position value so it’s always within 0 → max
                    final positionSeconds = position.inSeconds.toDouble().clamp(
                          0.0,
                          durationSeconds > 0 ? durationSeconds : 1.0,
                        );

                    return Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 16),
                          ),
                          child: Slider(
                            value: positionSeconds, // ✅ safe clamped value
                            min: 0.0,
                            max: durationSeconds > 0 ? durationSeconds : 1.0,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                            onChanged: (value) {
                              controller.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 60),

                  // Large Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Backward Button
                      GestureDetector(
                        onTap: () => controller.seekBackward(),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomIcon(
                              title: 'assets/icons/a1.svg',
                              height: 40,
                              width: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),

                      Container(
                        height: 100,
                        width: 1.5,
                        color: Colors.grey[200],
                      ),
                      const SizedBox(width: 40),

                      // Forward Button
                      GestureDetector(
                        onTap: () => controller.seekForward(),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomIcon(
                              title: 'assets/icons/a2.svg',
                              height: 40,
                              width: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
