import 'dart:async';

import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/modules/auth/controllers/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationSheetContent extends StatefulWidget {
  const OtpVerificationSheetContent({super.key});

  @override
  State<OtpVerificationSheetContent> createState() =>
      _OtpVerificationSheetContentState();
}

class _OtpVerificationSheetContentState
    extends State<OtpVerificationSheetContent> {
  final TextEditingController _pinController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final FocusNode _focusNode = FocusNode();
  late Timer _timer;
  int _start = 60; // Countdown from 60 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _start = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendCode() {
    // Implement actual resend logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resending code...')),
    );
    _startTimer(); // Restart the timer
  }

  @override
  Widget build(BuildContext context) {
    // Default Pinput theme
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    // Focused Pinput theme (when a digit is being entered)
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red), // Red border as in the image
    );

    // Submitted Pinput theme (when a digit is already entered)
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: StringConstants.SFPro,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),

            const Text(
              'Phone Number Code',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'ll receive 5 digit code to verify your login.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     onPressed: () {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('Change Phone Number tapped')),
            //       );
            //     },
            //     style: TextButton.styleFrom(
            //       padding: EdgeInsets.zero,
            //       alignment: Alignment.centerLeft,
            //     ),
            //     child: const Text(
            //       'Change Phone Number',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),

            Center(
              child: Pinput(
                length: 5,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                keyboardType: TextInputType.number, // Show native number pad
                // Remove the custom keypad integration

                onCompleted: (pin) {
                  debugPrint('Completed: $pin');
                },
                onChanged: (value) {
                  debugPrint('Changed: $value');
                  setState(() {
                    // Update the Continue button state
                  });
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton(
                onPressed: _pinController.text.length == 5
                    ? () {
                        String otp = _pinController.text;
                        debugPrint('Verifying OTP: $otp');

                        // Log in the user
                        authController.login();

                        // Navigate to ProfileScreen
                        Get.offAll(() => const BottomNavScreen());
                      }
                    : null, // disabled if OTP not complete
                style: ElevatedButton.styleFrom(
                  backgroundColor: _pinController.text.length == 5
                      ? Colors.red
                      : Colors.grey.shade200,
                  foregroundColor: _pinController.text.length == 5
                      ? Colors.white
                      : Colors.grey.shade500,
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent Code Timer / Resend Button
            Center(
              child: _canResend
                  ? TextButton(
                      onPressed: _resendCode,
                      child: const Text(
                        'Recent Code',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Text(
                      'Recent Code ( 00:${_start.toString().padLeft(2, '0')} )',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
            const SizedBox(
                height:
                    40), // Increased bottom padding for better spacing in the sheet
          ],
        ),
      ),
    );
  }
}
