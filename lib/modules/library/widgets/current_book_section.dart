import 'package:flutter/material.dart';

class CurrentBookSection extends StatelessWidget {
  const CurrentBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),

              image: const DecorationImage(
                image: AssetImage('assets/images/b1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
