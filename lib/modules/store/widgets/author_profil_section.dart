import 'package:flutter/material.dart';

class AuthorProfileSection extends StatelessWidget {
  const AuthorProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/a1.png'),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey.shade800, Colors.grey.shade600],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const SizedBox(height: 24),
          const AuthorInfo(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class AuthorInfo extends StatelessWidget {
  const AuthorInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Mark Manson',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Author',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text:
                      'Mark Manson is a bestselling author, blogger, '
                      'and personal development consultant known '
                      'for his bluntstraightforward advice.. ',
                ),
                TextSpan(
                  text: 'Show more',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
