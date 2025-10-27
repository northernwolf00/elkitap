import 'package:flutter/material.dart';

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
                    // Book Cover with Shadow
                    Container(
                      width: 280,
                      height: 420,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFF6B35),
                                Color(0xFFFF4500),
                              ],
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Top Banner
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  color: const Color(0xFFFF8C42),
                                  child: const Text(
                                    '#1 NEW YORK TIMES BESTSELLER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              
                              // Main Title
                              Positioned(
                                top: 60,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'THE\nSUBTLE\nART OF\nNOT\nGIVING\nA F*CK',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF1A1A1A),
                                        height: 1.1,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Author Badge
                              Positioned(
                                top: 340,
                                right: 20,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'AUTHOR OF',
                                        style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'EVERYTHING\nIS F*CKED:\nA BOOK ABOUT\nHOPE',
                                        style: TextStyle(
                                          fontSize: 6,
                                          color: Color(0xFF666666),
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Subtitle
                              Positioned(
                                bottom: 80,
                                left: 20,
                                right: 20,
                                child: const Text(
                                  'A COUNTERINTUITIVE APPROACH\nTO LIVING A GOOD LIFE',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              
                              // Author Name
                              Positioned(
                                bottom: 30,
                                left: 20,
                                right: 20,
                                child: const Text(
                                  'MARK MANSON',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF1A1A1A),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 80),
                    
                    // Animated Loading Eyes
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          size: const Size(80, 60),
                          painter: EyesPainter(_controller.value),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Loading Text
                    const Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
      center: Offset(size.width / 2 - eyeWidth / 2 - eyeSpacing / 2, size.height / 2),
      width: eyeWidth,
      height: eyeHeight,
    );
    canvas.drawOval(leftEyeRect, paint);

    // Right Eye
    final rightEyeRect = Rect.fromCenter(
      center: Offset(size.width / 2 + eyeWidth / 2 + eyeSpacing / 2, size.height / 2),
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