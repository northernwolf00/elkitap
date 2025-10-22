import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      ("Payment History", Icons.receipt_long),
      ("Theme", Icons.brightness_6),
      ("Language", Icons.language),
      ("Help & Support", Icons.help_outline),
      ("Legal Terms of Use", Icons.description_outlined),
      ("Privacy and Policy", Icons.privacy_tip_outlined),
      ("Sign Out", Icons.logout),
    ];

    return Column(
      children: settings
          .map(
            (item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Icon(item.$2),
              title: Text(item.$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          )
          .toList(),
    );
  }
}
