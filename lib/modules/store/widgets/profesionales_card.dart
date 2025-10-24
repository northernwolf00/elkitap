import 'package:elkitap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const ProfessionalCard({
    Key? key,
    required this.name,
    required this.role,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [Color(0x00E5E5EA), Color(0xFFE5E5EA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 40, backgroundImage: AssetImage(imageUrl)),
          const SizedBox(height: 12),
          Text(
            role,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.STORE_DETAIL);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 140,
            child: Image.asset(
              'assets/images/b8.png',
              width: 40,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
