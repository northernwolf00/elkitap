import 'package:elkitap/modules/store/widgets/profile_cart_widget.dart';
import 'package:elkitap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListProfileWidget extends StatefulWidget {
  const ListProfileWidget({super.key});

  @override
  State<ListProfileWidget> createState() => _ListProfileWidgetState();
}

class _ListProfileWidgetState extends State<ListProfileWidget> {
  final List<Map<String, dynamic>> professionals = [
    {
      'role': 'ARCHITECTS',
      'name': 'Azat Sary',
      'avatarInitials': 'A',
      'books': 5,
    },
    {'role': 'SALES', 'name': 'Merdan', 'avatarInitials': 'M', 'books': 4},
    {'role': 'DESIGN', 'name': 'Lea', 'avatarInitials': 'L', 'books': 4},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              // Navigate to professionals read view
              Get.toNamed(Routes.PROFESSIONALS_READ);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Professionals read',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'New York',
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),

        SizedBox(
          height: 265,
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: professionals.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, idx) {
              final p = professionals[idx];
              return ProfileCard(
                role: p['role'],
                name: p['name'],
                initials: p['avatarInitials'],
                bookCount: p['books'],
              );
            },
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }
}
