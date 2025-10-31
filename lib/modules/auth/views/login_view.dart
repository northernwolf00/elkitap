import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/language_sellector.dart';
import 'package:elkitap/modules/auth/widget/otp_bottom_sheet.dart';
import 'package:elkitap/modules/profile/widgets/help_and_support_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewScreen extends StatefulWidget {
  const AuthViewScreen({super.key});

  @override
  State<AuthViewScreen> createState() => _AuthViewScreenState();
}

class _AuthViewScreenState extends State<AuthViewScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {
      _isValid = _phoneController.text.trim().length > 7;
    });
  }

  void _showHelpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const HelpAndSupportBottomSheet(),
    );
  }

  void _showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Crucial for when the keyboard appears
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        // Use Padding to ensure content moves up when the keyboard is active
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const OtpVerificationSheetContent(),
        );
      },
    );
  }

  void _onContinuePressed() {
    if (_isValid) {
      // 👇 navigate or verify number
      print("Phone number: +993${_phoneController.text}");
      _showOtpBottomSheet(context);
    }
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChange);
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
        _isFocused ? const Color(0xFFFF6B35) : Colors.grey.shade400;
    final continueColor =
        _isValid ? const Color(0xFFFF6B35) : const Color(0xFFE5E5EA);
    final continueTextColor = _isValid ? Colors.white : const Color(0xFFC7C7CC);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios, size: 20),
                        SizedBox(width: 4),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: StringConstants.SFPro,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const LanguageSelector(),
                  const Spacer(),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showHelpBottomSheet(context);
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 28,
                fontFamily: StringConstants.SFPro,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your number to login your account.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: StringConstants.SFPro,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone number',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: StringConstants.SFPro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        const Text(
                          '+993',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: StringConstants.SFPro,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.grey.shade300,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _isValid ? _onContinuePressed : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: continueColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.w600,
                        color: continueTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: StringConstants.SFPro,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(text: 'By pressing Continue, you agree to the '),
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: ' and\n'),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
