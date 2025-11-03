// import 'dart:ui';

// import 'package:elkitap/modules/audio_player/controllers/audio_player_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class SpeedSelector extends StatelessWidget {
//   final AudioPlayerController controller;

//   const SpeedSelector({Key? key, required this.controller}) : super(key: key);

//   static void showSpeedPopup(
//       BuildContext context, AudioPlayerController controller) {
//     final speeds = [
//       {'value': 0.5, 'label': '0.5x'},
//       {'value': 0.75, 'label': '0.75x'},
//       {'value': 1.0, 'label': '1x'},
//       {'value': 1.5, 'label': '1.5x'},
//       {'value': 2.0, 'label': '2x'},
//     ];

//     showDialog(
//       context: context,
//       barrierColor: Colors.black26,
//       builder: (context) => Stack(
//         children: [
//           Positioned(
//             top: MediaQuery.of(context).size.height / 2 - 140,
//             left: MediaQuery.of(context).size.width / 2 - 100,
//             child: Material(
//               color: Colors.transparent,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                   child: Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).brightness == Brightness.dark
//                           ? Colors.black.withOpacity(0.85)
//                           : Colors.white.withOpacity(0.85),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white.withOpacity(0.3)
//                             : Colors.white.withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 30,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: speeds.map((speed) {
//                         final isLast = speed == speeds.last;
//                         final speedValue = speed['value'] as double;
//                         final speedLabel = speed['label'] as String;
                        
//                         return Column(
//                           children: [
//                             Obx(() => InkWell(
//                                   onTap: () {
//                                     controller.setSpeed(speedValue);
//                                     Navigator.pop(context);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 16,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             speedLabel,
//                                             style: TextStyle(
//                                               fontSize: 17,
//                                               fontFamily: 'SF Pro', // StringConstants.SFPro
//                                               fontWeight: FontWeight.w400,
//                                               color: controller.playbackSpeed.value == speedValue
//                                                   ? Colors.blue
//                                                   : Theme.of(context).brightness == Brightness.dark
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         if (controller.playbackSpeed.value == speedValue)
//                                           const Icon(
//                                             Icons.check,
//                                             size: 24,
//                                             color: Colors.blue,
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                 )),
//                             if (!isLast)
//                               Divider(
//                                 height: 1,
//                                 color: Colors.grey.withOpacity(0.2),
//                               ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// }