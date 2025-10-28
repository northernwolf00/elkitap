import 'package:elkitap/global_widgets/custom_appbar.dart';
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
      appBar: CustomAppBar(
        title: '',
        showBackButton: true,
        leadingText: 'Back',
      ),
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
