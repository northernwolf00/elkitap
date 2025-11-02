import 'package:elkitap/global_widgets/bottom_nav_button.dart';
import 'package:elkitap/modules/library/views/library_view.dart';
import 'package:elkitap/modules/search/views/search_view.dart';
import 'package:elkitap/modules/store/views/store_view.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 1;

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
        height: 70,
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
