import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final Function(String)? onDestClick;
  final startingIdx;
  static const unselectedColor = Colors.grey;
  static const selectedColor = Colors.blue;
  const BottomNav({this.startingIdx = 1, this.onDestClick, super.key});
  static const views = <String>["explore", "home", "profile"];

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int currentPageIndex;

  @override
  void initState() {
    currentPageIndex = widget.startingIdx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          navigationBarTheme: const NavigationBarThemeData(
        iconTheme: WidgetStatePropertyAll(IconThemeData(
          size: 30,
        )),
        labelTextStyle:
            WidgetStatePropertyAll(TextStyle(color: BottomNav.selectedColor)),
      )),
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          widget.onDestClick != null
              ? widget.onDestClick!(BottomNav.views[index])
              : null;
        },
        surfaceTintColor: BottomNav.selectedColor,
        indicatorColor: Colors.transparent,
        height: 60,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: NavigationDestination(
              selectedIcon: Icon(Icons.search, color: BottomNav.selectedColor),
              icon: Icon(
                Icons.search,
                color: BottomNav.unselectedColor,
              ),
              label: 'Explore',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: NavigationDestination(
              selectedIcon: Icon(Icons.email, color: BottomNav.selectedColor),
              icon: Icon(
                Icons.email_outlined,
                color: BottomNav.unselectedColor,
              ),
              label: 'Home',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: NavigationDestination(
              selectedIcon: Badge(
                label: Text('2'),
                child: Icon(Icons.person, color: BottomNav.selectedColor),
              ),
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.person, color: BottomNav.unselectedColor),
              ),
              label: 'Profile',
            ),
          ),
        ],
      ),
    );
  }
}
