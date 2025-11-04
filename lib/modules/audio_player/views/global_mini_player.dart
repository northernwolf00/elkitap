import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/views/audio_player_view.dart';

class GlobalMiniPlayer extends StatefulWidget {
  const GlobalMiniPlayer({Key? key}) : super(key: key);

  @override
  State<GlobalMiniPlayer> createState() => _GlobalMiniPlayerState();
}

class _GlobalMiniPlayerState extends State<GlobalMiniPlayer> {
  late GlobalMiniPlayerController globalMiniCtrl;

  @override
  void initState() {
    super.initState();
    globalMiniCtrl = Get.find<GlobalMiniPlayerController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final playerWidth = MediaQuery.of(context).size.width - 30;
      const playerHeight = 70.0;

      // 🟢 Start position: bottom center
      final initialTop =
          size.height - playerHeight - 100; // ~100px above bottom
      final initialLeft = (size.width / 2) - (playerWidth / 2);
      globalMiniCtrl.setPosition(initialTop, initialLeft);
    });
  }

  bool _shouldShowPlayer() {
    final currentRoute = Get.currentRoute;
    final excludedRoutes = [
      '/audiobook-player',
      '/AudiobookPlayerScreen',
      '/driver-mode',
      '/DriverModeScreen',
    ];
    return !excludedRoutes.any((r) => currentRoute.contains(r));
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowPlayer()) return const SizedBox.shrink();

    late AudioPlayerController controller;
    try {
      controller = Get.find<AudioPlayerController>();
    } catch (e) {
      return const SizedBox.shrink();
    }

    return Obx(() {
      if (!globalMiniCtrl.isVisible.value ||
          controller.duration.value == Duration.zero) {
        return const SizedBox.shrink();
      }

      final screenSize = MediaQuery.of(context).size;
      final playerWidth = 180;
      const playerHeight = 70.0;

      return Positioned(
        top: globalMiniCtrl.top.value,
        left: globalMiniCtrl.left.value,
        child: GestureDetector(
          onPanUpdate: (details) {
            // 🟢 Move freely in all directions
            final newTop = (globalMiniCtrl.top.value + details.delta.dy)
                .clamp(0.0, screenSize.height - playerHeight - 20);
            final newLeft = (globalMiniCtrl.left.value + details.delta.dx)
                .clamp(0.0, screenSize.width - playerWidth - 10);
            globalMiniCtrl.setPosition(newTop, newLeft);
          },
          onPanEnd: (details) {
            double snapLeft = globalMiniCtrl.left.value;
            double snapTop = globalMiniCtrl.top.value;

            const snapDistance = 40.0;
            if (snapLeft < snapDistance) snapLeft = 10;
            if (snapLeft > screenSize.width - playerWidth - snapDistance) {
              snapLeft = screenSize.width - playerWidth - 10;
            }
            if (snapTop < snapDistance) snapTop = 20;
            if (snapTop > screenSize.height - playerHeight - snapDistance) {
              snapTop = screenSize.height - playerHeight - 20;
            }

            globalMiniCtrl.setPosition(snapTop, snapLeft);
          },
          onTap: () {
            Get.to(() => const AudiobookPlayerScreen());
            globalMiniCtrl.hide();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: playerHeight,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/b6.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF8B5A3C),
                        child: const Icon(Icons.book, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        child: Text(
                          'The Subtle Art...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(() {
                        return DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          child: Text(
                            '${controller.formatDuration(controller.position.value)} left',
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => controller.seekBackward(),
                  child: CustomIcon(
                    title: 'assets/icons/a1.svg',
                    height: 28,
                    width: 28,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => controller.playPause(),
                  child: Obx(() => CustomIcon(
                        title: controller.isPlaying.value
                            ? 'assets/icons/a4.svg'
                            : 'assets/icons/a3.svg',
                        height: 28,
                        width: 28,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      );
    });
  }
}
