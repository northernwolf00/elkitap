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
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavbarButton> createState() => _BottomNavbarButtonState();
}

class _BottomNavbarButtonState extends State<BottomNavbarButton> {
  List<String> title = [
    'My Library',
    'Book Store',
    'Search',
   
  ];

  List iconsLight = [
    CustomIcon(
      title: 'assets/icons/library_filld.svg',
      height: 20.8,
      width: 20.77,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/bag.svg',
      height: 20.8,
      width: 20.77,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/search.svg',
      height: 20.8,
      width: 20.77,
      color: AppColors.disableColor,
    ),
   
  ];

  List iconsBold = [
    CustomIcon(
      title: 'assets/icons/library_filld.svg',
      height: 20.8,
      width: 20.77,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/bag.svg',
      height: 20.8,
      width: 20.77,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/search.svg',
      height: 20.8,
      width: 20.77,
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
              height: widget.index == widget.selectedIndex ? 68 : 0,
              decoration: const BoxDecoration(),
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Column(
                children: [
                  // Container(
                  //   height: 1,
                  //   decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(12),
                  //           topRight: Radius.circular(12))
                  //           ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Visibility(
                      visible: widget.index == widget.selectedIndex,
                      child: Container(
                        height: 6,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        widget.index != widget.selectedIndex
                            ? widget.icon
                                ? const Icon(Icons.local_activity)
                                : Container(
                                  child: Center(
                                    child: Badge(
                                      isLabelVisible:
                                          widget.index == 2 ? true : false,
                                      backgroundColor: AppColors.mainColor,
                                      label: Visibility(
                                        visible:
                                            widget.index == 2 ? true : false,
                                        child: Text(
                                          'ff',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: iconsLight[widget.index],
                                    ),
                                  ),
                                )
                            // Icon(
                            //     iconsLight[index],
                            //     size: 18,
                            //     color: Colors.black,
                            //   )
                            : widget.icon
                            ? const Icon(Icons.add)
                            : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Badge(
                                  isLabelVisible:
                                      widget.index == 2 ? true : false,
                                  backgroundColor: AppColors.mainColor,
                                  label: Visibility(
                                    visible: widget.index == 2 ? true : false,
                                    child: Text(
                                      'ddd',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: iconsBold[widget.index],
                                ),
                              ),

                              // Icon(
                              //   iconsBold[index],
                              //   size: 18,
                              //   color: Colors.amber,
                              // ),
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
        ],
      ),
    );
  }
}
