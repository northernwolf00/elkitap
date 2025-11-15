import 'dart:async';

import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/bottom_nav_bar.dart';
import 'package:elkitap/modules/auth/controllers/auth_controller.dart';

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

  void _resendCode() async {
  if (authController.isLoading.value) return;

  authController.isLoading.value = true;

  // Show loading
  Get.dialog(
    Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const CircularProgressIndicator(),
      ),
    ),
    barrierDismissible: false,
  );

  // Call API
  final success = await authController.sendCode(authController.currentPhone.value);

  // Close dialog safely
  if (Get.isDialogOpen == true) {
    await Future.delayed(const Duration(milliseconds: 200));
    Get.back();
  }

  authController.isLoading.value = false;

  if (success) {
    _startTimer();
    Get.snackbar(
      'Success',
      'Code resent successfully',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  } else {
    Get.snackbar(
      'Error',
      'Failed to resend code',
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
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

    // Focused Pinput theme
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFFFF6B35), width: 2),
    );

    // Submitted Pinput theme
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
                Text(
                  'leading_text'.tr,
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: StringConstants.SFPro,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              'phoneNumberCode'.tr,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text('receive5DigitCode'.tr),
            const SizedBox(height: 24),

            Center(
              child: Pinput(
                length: 4,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                keyboardType: TextInputType.number,
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

            // Continue Button with API Integration
            Center(
              child: Obx(() {
                return ElevatedButton(
                  onPressed: _pinController.text.length == 4 && !authController.isLoading.value
                      ? () async {
                          String otp = _pinController.text;
                          debugPrint('Verifying OTP: $otp');
                          
                          // Show loading dialog
                          Get.dialog(
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                            barrierDismissible: false,
                          );
                          
                          // Verify code and login
                          final success = await authController.verifyCodeAndLogin(otp);
                          
                          // Close loading dialog
                          Get.back();
                          
                          if (success) {
                            // Close OTP sheet
                            Navigator.pop(context);
                            
                            // Navigate to home
                            Get.offAll(() => const BottomNavScreen());
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pinController.text.length == 4
                        ? const Color(0xFFFF6B35)
                        : Colors.grey.shade200,
                    foregroundColor: _pinController.text.length == 4
                        ? Colors.white
                        : Colors.grey.shade500,
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authController.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'continue_text'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Resend Code Timer / Button
            Center(
              child: _canResend
                  ? TextButton(
                      onPressed: _resendCode,
                      child: Text(
                        'recentCode'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFF6B35),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Text(
                      '${'recentCodeWithTimer'.tr} ${_start.toString().padLeft(2, '0')} )',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}