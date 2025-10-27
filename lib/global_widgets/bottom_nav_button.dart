import 'package:elkitap/core/theme/app_colors.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavbarButton extends StatefulWidget {
  final Function() onTapp;
  final int selectedIndex;
  final int index;
  final bool icon;
  const BottomNavbarButton({
    required this.onTapp,
    required this.selectedIndex,
    required this.index,
    required this.icon,
    super.key,
  });

  @override
  State<BottomNavbarButton> createState() => _BottomNavbarButtonState();
}

class _BottomNavbarButtonState extends State<BottomNavbarButton> {
  List<String> title = ['My Library', 'Book Store', 'Search'];

  List iconsLight = [
    CustomIcon(
      title: 'assets/icons/library_filled.svg',
      height: 32,
      width: 32,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/bag.svg',
      height: 32,
      width: 32,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/search.svg',
      height: 32,
      width: 32,
      color: AppColors.disableColor,
    ),
  ];

  List iconsBold = [
    CustomIcon(
      title: 'assets/icons/library_filled.svg',
      height: 32,
      width: 32,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/bag.svg',
      height: 32,
      width: 32,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/search.svg',
      height: 32,
      width: 32,
      color: AppColors.mainColor,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapp,
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              width: double.infinity,
              height: widget.index == widget.selectedIndex ? 80 : 0,
              decoration: const BoxDecoration(),
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Column(
                children: [
                  Expanded(
                    child:
                        widget.index != widget.selectedIndex
                            ? widget.icon
                                ? const Icon(Icons.local_activity)
                                : Center(
                                  child: iconsLight[widget.index],
                                )
                            : widget.icon
                            ? const Icon(Icons.add)
                            : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(child: iconsBold[widget.index]),
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      title[widget.index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            widget.index == widget.selectedIndex
                                ? AppColors.mainColor
                                : AppColors.disableColor,
                        fontWeight:
                            widget.index == widget.selectedIndex
                                ? FontWeight.w600
                                : FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Rubik',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
