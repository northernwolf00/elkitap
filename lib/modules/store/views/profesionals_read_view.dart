import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/store/widgets/profesionales_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionalsReadView extends StatelessWidget {
  const ProfessionalsReadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Professionals read', leadingText: 'leading_text'.tr),
      body: ListView(
        children: const [
          ProfessionalCard(
            name: 'Merdan Durnayew',
            role: 'DIRECTOR',
            imageUrl: 'assets/images/a1.png',
          ),
          ProfessionalCard(
            name: 'Azat Sary',
            role: 'ARCHITECS',
            imageUrl: 'assets/images/a1.png',
          ),
          ProfessionalCard(
            name: 'Azat Sary',
            role: 'ARCHITECS',
            imageUrl: 'assets/images/a1.png',
          ),
        ],
      ),
    );
  }
}
