import 'package:elkitap/global_widgets/bottom_nav_button.dart';
import 'package:elkitap/modules/library/views/library_view.dart';
import 'package:elkitap/modules/search/views/search_view.dart';
import 'package:elkitap/modules/store/views/store_view.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  bool isvisible = false;
  @override
  void dispose() {
    super.dispose();
  }

  List page = [MyLibraryViewScreen(), StoreViewScreen(), SearchViewScreen()];

  @override
  void initState() {
    super.initState();
  }

  bool appbar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 0,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(0);
                },
              ),
            ),
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 1,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(1);
                },
              ),
            ),
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 2,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(2);
                },
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        // index: selectedIndex,
        children: [Center(child: page[selectedIndex])],
      ),
    );
  }

  void onTapp(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }
}
