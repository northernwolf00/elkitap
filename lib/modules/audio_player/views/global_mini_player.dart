import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/views/audio_player_view.dart';

class GlobalMiniPlayer extends StatelessWidget {
  const GlobalMiniPlayer({Key? key}) : super(key: key);

  bool _shouldShowPlayer() {
    final currentRoute = Get.currentRoute;

    // Don’t show on full player screen or driver mode
    final excludedRoutes = [
      '/audiobook-player',
      '/AudiobookPlayerScreen',
      '/driver-mode',
      '/DriverModeScreen',
    ];

    for (var route in excludedRoutes) {
      if (currentRoute.contains(route)) return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowPlayer()) return const SizedBox.shrink();

    late AudioPlayerController controller;
    try {
      controller = Get.find<AudioPlayerController>();
    } catch (e) {
      // Not initialized yet
      return const SizedBox.shrink();
    }
    final globalMiniCtrl = Get.find<GlobalMiniPlayerController>();

    return Obx(() {
      if (controller.duration.value == Duration.zero) {
        return const SizedBox.shrink();
      }

      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const AudiobookPlayerScreen());
              globalMiniCtrl.hide();
            },
            onVerticalDragUpdate: (details) {
              final dragOffset = details.primaryDelta ?? 0;
              if (dragOffset > 12) {
                controller.stopAudio();
              }
            },
            child: Container(
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Book cover
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/b6.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF8B5A3C),
                              child: const Icon(
                                Icons.book,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Subtle Art...',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          return Text(
                            '${controller.formatDuration(controller.position.value)} left',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),
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

                  GestureDetector(
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
                        ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
