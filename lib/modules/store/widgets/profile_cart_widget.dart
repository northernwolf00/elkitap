import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String role;
  final String name;
  final String initials;
  final int bookCount;

  const ProfileCard({
    super.key,
    required this.role,
    required this.name,
    required this.initials,
    required this.bookCount,
  });

  // A small "shelf" with placeholder book cover cards
  Widget _buildShelf(BuildContext context) {
    return Container(
      width: 215,
      height: 94,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/b8.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 0,
          child: Text(
            'Book',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // top spacing
          SizedBox(height: 14),

          // avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[800],
            child: Image.asset('assets/images/u1.png', fit: BoxFit.cover),
          ),

          SizedBox(height: 10),
          Text(
            role.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 1.0,
            ),
          ),

          SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildShelf(context),
          ),
        ],
      ),
    );
  }
}
