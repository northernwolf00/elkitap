import 'dart:ui';

import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
import 'package:elkitap/modules/audio_player/views/driver_mode_screen.dart';

import 'package:elkitap/modules/audio_player/widgets/audiobook_bottom_sheet.dart';
import 'package:elkitap/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AudiobookPlayerScreen extends StatelessWidget {
  const AudiobookPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AudioPlayerController());
    // final bluetoothController = Get.put(BluetoothController());
  
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
                          onPressed: () {
                            DialogUtils.showAudioPopupMenu(context);
                          },
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
                                children: [],
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
               SizedBox(height: 40),

              // Bottom Controls
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => showSpeedPopup(context, controller),
                      child: Text(
                        '${controller.playbackSpeed.value}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SFPro', // StringConstants.SFPro
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => showSleepTimerPopup(context, controller),
                        child: Obx(() {
                          final hasTimer =
                              controller.sleepTimerEndTime.value != null;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bedtime_outlined,
                                size: 32,
                                color: Colors.white,
                              ),
                              if (hasTimer) ...[
                                const SizedBox(width: 8),
                                Text(
                                  controller.getRemainingTime(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'SFPro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          );
                        }),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showBluetoothPopup(context);
                        },
                        
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIcon(
                              title: 'assets/icons/a6.svg',
                              height: 32,
                              width: 32,
                              color: Colors.white,
                            ),
                            // if (hasConnection) ...[
                              // const SizedBox(width: 8),
                              // Icon(
                              //   bluetoothController.getDeviceIcon(
                              //       bluetoothController
                              //           .connectedDevice.value!),
                              //   size: 20,
                              //   color: Colors.white70,
                              // ),
                            // ],
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          final controller = Get.find<AudioPlayerController>();
                          controller.enableDriverMode();
                          Get.to(() => const DriverModeScreen());
                        },
                        child: CustomIcon(
                          title: 'assets/icons/a7.svg',
                          height: 32,
                          width: 32,
                          color: Colors.white,
                        ),
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

  static void showSpeedPopup(
      BuildContext context, AudioPlayerController controller) {
    final speeds = [
      {'value': 0.5, 'label': '0.5x'},
      {'value': 0.75, 'label': '0.75x'},
      {'value': 1.0, 'label': '1x'},
      {'value': 1.5, 'label': '1.5x'},
      {'value': 2.0, 'label': '2x'},
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          Positioned(
            bottom: 80,
            left: 20,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3633).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: speeds.map((speed) {
                        final isLast = speed == speeds.last;
                        final speedValue = speed['value'] as double;
                        final speedLabel = speed['label'] as String;

                        return Column(
                          children: [
                            Obx(() => InkWell(
                                  onTap: () {
                                    controller.setSpeed(speedValue);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            speedLabel,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily:
                                                  'SFPro', // StringConstants.SFPro
                                              fontWeight: FontWeight.w400,
                                              color: controller.playbackSpeed
                                                          .value ==
                                                      speedValue
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        if (controller.playbackSpeed.value ==
                                            speedValue)
                                          const Icon(
                                            Icons.check,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                      ],
                                    ),
                                  ),
                                )),
                            if (!isLast)
                              Divider(
                                height: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showSleepTimerPopup(
      BuildContext context, AudioPlayerController controller) {
    final timers = [
      {'duration': const Duration(hours: 1), 'label': '1 hour'},
      {'duration': const Duration(minutes: 45), 'label': '45 minutes'},
      {'duration': const Duration(minutes: 15), 'label': '15 minutes'},
      {'duration': const Duration(minutes: 10), 'label': '10 minutes'},
      {'duration': const Duration(minutes: 5), 'label': '5 minutes'},
      {'duration': null, 'label': 'Off'},
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          Positioned(
            bottom: 80,
            left: 20,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 240,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3633).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'When Current chapter ends',
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Divider after header
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.15),
                        ),
                        // Timer options
                        ...timers.map((timer) {
                          final isLast = timer == timers.last;
                          final timerDuration = timer['duration'] as Duration?;
                          final timerLabel = timer['label'] as String;

                          return Column(
                            children: [
                              Obx(() => InkWell(
                                    onTap: () {
                                      controller.setSleepTimer(timerDuration);
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              timerLabel,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'SF Pro',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          if (controller
                                                  .sleepTimerDuration.value ==
                                              timerDuration)
                                            const Icon(
                                              Icons.check,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                        ],
                                      ),
                                    ),
                                  )),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.white.withOpacity(0.15),
                                ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showBluetoothPopup(
      BuildContext context) {


    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (context) => Stack(
        children: [
          Positioned(
            bottom: 80,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 320,
                    constraints: const BoxConstraints(maxHeight: 400),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3633).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.broadcast_on_personal,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Broadcasting',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.15),
                        ),
                        // Device list
                        Flexible(
                          child: 
                            // if (!controller.isBluetoothEnabled.value) {
                            //   return Padding(
                            //     padding: const EdgeInsets.all(40),
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         const Icon(
                            //           Icons.bluetooth_disabled,
                            //           color: Colors.white70,
                            //           size: 48,
                            //         ),
                            //         const SizedBox(height: 16),
                            //         const Text(
                            //           'Bluetooth is disabled',
                            //           style: TextStyle(
                            //             fontSize: 15,
                            //             fontFamily: 'SF Pro',
                            //             color: Colors.white70,
                            //           ),
                            //         ),
                            //         const SizedBox(height: 16),
                            //         ElevatedButton(
                            //           onPressed: () =>
                            //               controller.enableBluetooth(),
                            //           child: const Text('Enable Bluetooth'),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }

                            // if (controller.isSearching.value) {
                            //   return Padding(
                            //     padding: const EdgeInsets.all(40),
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         const CircularProgressIndicator(
                            //           color: Colors.white,
                            //           strokeWidth: 2,
                            //         ),
                            //         const SizedBox(height: 16),
                            //         const Text(
                            //           'Searching Devices',
                            //           style: TextStyle(
                            //             fontSize: 15,
                            //             fontFamily: 'SF Pro',
                            //             color: Colors.white70,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }

                            // final allDevices = [
                            //   ...controller.pairedDevices,
                            //   ...controller.discoveredDevices
                            //       .map((r) => r.device),
                            // ];

                            // // Remove duplicates
                            // final uniqueDevices = <BluetoothDevice>[];
                            // final addresses = <String>{};
                            // for (var device in allDevices) {
                            //   if (!addresses.contains(device.address)) {
                            //     addresses.add(device.address);
                            //     uniqueDevices.add(device);
                            //   }
                            // }

                            // if (uniqueDevices.isEmpty) {
                            //   return Padding(
                            //     padding: const EdgeInsets.all(40),
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         const Text(
                            //           'No devices found',
                            //           style: TextStyle(
                            //             fontSize: 15,
                            //             fontFamily: 'SF Pro',
                            //             color: Colors.white70,
                            //           ),
                            //         ),
                            //         const SizedBox(height: 16),
                            //         TextButton(
                            //           onPressed: () =>
                            //               controller.startDiscovery(),
                            //           child: const Text('Scan Again'),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }

                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: 2,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.white.withOpacity(0.15),
                              ),
                              itemBuilder: (context, index) {
                                // final device = uniqueDevices[index];
                                // final isConnected =
                                //     controller.connectedDevice.value?.address ==
                                //         device.address;

                                return InkWell(
                                  onTap: () {
                                    // controller.connectToDevice(device);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_android,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               'Unknown Device',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'SF Pro',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // if (device.name == null ||
                                              //     device.name!.isEmpty)
                                              //   Text(
                                              //     device.address,
                                              //     style: TextStyle(
                                              //       fontSize: 13,
                                              //       fontFamily: 'SF Pro',
                                              //       color: Colors.white70,
                                              //     ),
                                              //   ),
                                            ],
                                          ),
                                        ),
                                        // if (isConnected)
                                        //   const Icon(
                                        //     Icons.check,
                                        //     size: 24,
                                        //     color: Colors.white,
                                        //   ),
                                      ],
                                    ),
                                  ),
                                );
                              
                            
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).then((_) {
      // Cancel discovery when dialog closes
      // controller.cancelDiscovery();
    });
  }
}
