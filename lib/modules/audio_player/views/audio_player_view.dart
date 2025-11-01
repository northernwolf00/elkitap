import 'dart:ui';

import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/widgets/audiobook_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudiobookPlayerScreen extends StatelessWidget {
  const AudiobookPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AudioPlayerController());

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
      // Blur Effect
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
      // Content
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      CustomIcon(
                          title: 'assets/icons/a9.svg',
                          height: 30,
                          width: 30,
                          color: Colors.white),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: IconButton(
                          icon:
                              const Icon(Icons.more_horiz, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Book Cover
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/b6.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //     horizontal: 12,
                                  //     vertical: 6,
                                  //   ),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.black,
                                  //     borderRadius: BorderRadius.circular(4),
                                  //   ),
                                  //   child: const Text(
                                  //     'SHORT BOOK SUMMARY',
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 30),
                                  // const Text(
                                  //   'THE SUBTLE ART\nOF NOT GIVING\nA F*CK',
                                  //   style: TextStyle(
                                  //     fontSize: 32,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.black,
                                  //     height: 1.2,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 20),
                                  // const Text(
                                  //   'STOP STRESSING,\nSTART LIVING.',
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     color: Colors.black,
                                  //     height: 1.3,
                                  //   ),
                                  // ),
                                  // const Spacer(),
                                  // const Text(
                                  //   'MARK MANSON',
                                  //   style: TextStyle(
                                  //     fontSize: 24,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Chapter Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chapter 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: StringConstants.NewYork,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'The Subtle art of not giving - Mark Manson',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: StringConstants.SFPro,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const AudiobookBottomSheet(),
                      );
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: Center(
                          child: CustomIcon(
                              title: 'assets/icons/a8.svg',
                              height: 24,
                              width: 24,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Progress Bar
              Obx(() {
                return Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 16,
                        ),
                      ),
                      child: Slider(
                        value: controller.position.value.inSeconds.toDouble(),
                        max: controller.duration.value.inSeconds.toDouble() > 0
                            ? controller.duration.value.inSeconds.toDouble()
                            : 1.0,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white30,
                        onChanged: (value) {
                          controller.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller
                                .formatDuration(controller.position.value),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: StringConstants.SFPro,
                            ),
                          ),
                          Text(
                            '${controller.formatDuration(controller.duration.value)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: StringConstants.SFPro,
                            ),
                          ),
                          Text(
                            '-${controller.formatDuration(controller.duration.value - controller.position.value)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: StringConstants.SFPro,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // Playback Controls
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.seekBackward();
                        },
                        child: CustomIcon(
                            title: 'assets/icons/a1.svg',
                            height: 40,
                            width: 40,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 40),
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade900,
                        child: GestureDetector(
                          onTap: () {
                            controller.playPause();
                          },
                          child: CustomIcon(
                              title: controller.isPlaying.value
                                  ? 'assets/icons/a4.svg'
                                  : 'assets/icons/a3.svg',
                              height: 40,
                              width: 40,
                              color: Colors.white),
                        )),
                    const SizedBox(width: 40),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.seekForward();
                        },
                        child: CustomIcon(
                            title: 'assets/icons/a2.svg',
                            height: 40,
                            width: 40,
                            color: Colors.white),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 30),

              // Bottom Controls
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: controller.changeSpeed,
                      child: Text(
                        '${controller.playbackSpeed.value}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: StringConstants.SFPro,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: CustomIcon(
                            title: 'assets/icons/a5.svg',
                            height: 32,
                            width: 32,
                            color: Colors.white),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: CustomIcon(
                            title: 'assets/icons/a6.svg',
                            height: 32,
                            width: 32,
                            color: Colors.white),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: CustomIcon(
                            title: 'assets/icons/a7.svg',
                            height: 32,
                            width: 32,
                            color: Colors.white),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    ]));
  }
}
