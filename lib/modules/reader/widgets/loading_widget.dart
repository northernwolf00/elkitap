import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar Space
            const SizedBox(height: 40),

            // Book Cover
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/b4.png',
                        width: 220, height: 330, fit: BoxFit.cover),

                    const SizedBox(height: 80),

                    // Animated Loading Eyes
                    Image.asset('assets/images/l1.png',
                        width: 60, height: 30, fit: BoxFit.cover),

                    const SizedBox(height: 20),

                    // Loading Text
                    Text(
                      'loading_t'.tr,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Animated Eyes
class EyesPainter extends CustomPainter {
  final double animationValue;

  EyesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6B35)
      ..style = PaintingStyle.fill;

    final eyeWidth = 28.0;
    final eyeHeight = 28.0;
    final eyeSpacing = 12.0;

    // Left Eye
    final leftEyeRect = Rect.fromCenter(
      center: Offset(
          size.width / 2 - eyeWidth / 2 - eyeSpacing / 2, size.height / 2),
      width: eyeWidth,
      height: eyeHeight,
    );
    canvas.drawOval(leftEyeRect, paint);

    // Right Eye
    final rightEyeRect = Rect.fromCenter(
      center: Offset(
          size.width / 2 + eyeWidth / 2 + eyeSpacing / 2, size.height / 2),
      width: eyeWidth,
      height: eyeHeight,
    );
    canvas.drawOval(rightEyeRect, paint);

    // Pupils with animation
    final pupilPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    final pupilSize = 10.0;
    final blinkHeight = eyeHeight * (1 - (animationValue * 2 - 1).abs());

    // Left Pupil
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          leftEyeRect.center.dx,
          leftEyeRect.center.dy,
        ),
        width: pupilSize,
        height: blinkHeight.clamp(2.0, pupilSize),
      ),
      pupilPaint,
    );

    // Right Pupil
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          rightEyeRect.center.dx,
          rightEyeRect.center.dy,
        ),
        width: pupilSize,
        height: blinkHeight.clamp(2.0, pupilSize),
      ),
      pupilPaint,
    );

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final smilePath = Path();
    smilePath.moveTo(size.width / 2 - 20, size.height - 10);
    smilePath.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width / 2 + 20,
      size.height - 10,
    );
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(EyesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
