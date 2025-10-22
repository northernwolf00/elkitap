import 'package:elkitap/modules/profile/widgets/profile_card_user.dart';
import 'package:elkitap/modules/profile/widgets/settings_list.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSubscribed = false;
  int daysLeft = 35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCardUser(
              isSubscribed: isSubscribed,
              daysLeft: daysLeft,
              onSubscribe: () => setState(() => isSubscribed = true),
            ),
            const SizedBox(height: 24),
            const SettingsList(),
          ],
        ),
      ),
    );
  }
}
