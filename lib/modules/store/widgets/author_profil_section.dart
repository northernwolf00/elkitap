import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


class AuthorProfileSection extends StatefulWidget {
  const AuthorProfileSection({Key? key}) : super(key: key);

  @override
  State<AuthorProfileSection> createState() => _AuthorProfileSectionState();
}

class _AuthorProfileSectionState extends State<AuthorProfileSection> {
  bool isExpanded = false;

  final String shortBio =
      "Merdan Durnayew is a film director known for his unique visual storytelling...";
  final String fullBio =
      "Merdan Durnayew is a film director known for his unique visual storytelling and impactful narratives. "
      "He has directed several acclaimed projects that explore emotion and culture in depth.";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Image
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              color: Colors.white,
              child: Image.asset(
                'assets/images/u2.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey[500],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.95),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.3, 0.6, 0.85, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Profile Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Merdan Durnayew',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'New York',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Director',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: isExpanded ? fullBio : shortBio),
                    TextSpan(
                      text: isExpanded ? ' Show Less' : ' Show More',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





