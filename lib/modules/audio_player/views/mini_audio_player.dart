import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/views/audio_player_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiniAudioPlayer extends StatelessWidget {
  const MiniAudioPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioPlayerController>();

    return Obx(() {
      // Only show if audio is loaded and controller is initialized
      if (controller.duration.value == Duration.zero) {
        return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: () {
          // Navigate to full player screen
          Get.to(() => const AudiobookPlayerScreen());
        },
        child: Container(
          height: 70,
          margin: const EdgeInsets.all(12),
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
              // Book Cover
              Container(
                width: 70,
                height: 70,
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

              const SizedBox(width: 12),

              // Book Info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The subtle art of not givin...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringConstants.SFPro,
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
                          fontFamily: StringConstants.SFPro,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Time Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 4),
                    Obx(() {
                      final remaining =
                          controller.duration.value - controller.position.value;
                      return Text(
                        controller.formatDuration(remaining),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringConstants.SFPro,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Play/Pause Button
              GestureDetector(
                onTap: () => controller.playPause(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Obx(() {
                      return Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(width: 12),
            ],
          ),
        ),
      );
    });
  }
}
