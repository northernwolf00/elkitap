import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlySearchedScreen extends StatelessWidget {
  final List<String> recentlySearched = [
    'How to Unfolds',
    'StopOverthing',
    'Power',
    'Rich dad poor dad',
  ];

   RecentlySearchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
          'recentlySearched'.tr,
          style: TextStyle(
           fontFamily: StringConstants.SFPro,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
            onPressed: () {
              // Handle clear action
              print('Clear recently searched');
            },
            child:  Text(
              'clear'.tr,
              style: TextStyle(
                 fontFamily: StringConstants.SFPro,
                color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white 
    : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: recentlySearched.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.grey),
                  title: Text(
                    recentlySearched[index],
                    
                    style: const TextStyle(
                      
                       fontFamily: StringConstants.SFPro,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // Handle search item tap
                    print('Tapped on: ${recentlySearched[index]}');
                  },
                ),
                if (index < recentlySearched.length - 1)
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                    indent: 56, // Align with the text, past the icon
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}