import 'package:elkitap/core/constants/string_constants.dart';

import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final Function(int) onTabChanged;

  const CustomTabBar({super.key, required this.onTabChanged});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TabItem(
            text: "Books",
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              widget.onTabChanged(0);
            },
          ),
          const SizedBox(width: 24),
          _TabItem(
            text: "Audiobooks",
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
              widget.onTabChanged(1);
            },
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 28,
              fontFamily: StringConstants.NewYork,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
              color: isSelected
                  ? Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black
                  : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 1.5,
            width: text.length * 18.0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey[300] : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
