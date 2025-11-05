import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios, size: 20)),
                    Text(
                      'profile'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: StringConstants.SFPro,
                      ),
                    ),
                     Expanded(
                      child: Center(
                        child: Text(
                          'legal_terms_of_use'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringConstants.SFPro,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                     Text(
                      'legal_terms_of_use'.tr,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: StringConstants.NewYork,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'last_updated_on'.tr,
                      style: TextStyle(
                        fontFamily: StringConstants.SFPro,
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Repeated sections
                    _buildSection(),
                    const SizedBox(height: 32),
                    _buildSection(),
                    const SizedBox(height: 32),
                    _buildSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'general_rules'.tr,
          style: TextStyle(
            fontSize: 20,
            fontFamily: StringConstants.NewYork,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'welcome_message'.tr,
          style: TextStyle(
            fontSize: 15,
            fontFamily: StringConstants.SFPro,
            height: 1.5,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
