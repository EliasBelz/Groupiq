import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final Function(int)? onDestClick;
  final startingIdx;
  static const unselectedColor = Colors.grey;
  static const selectedColor = Colors.blue;
  const BottomNav({this.startingIdx = 0, this.onDestClick, super.key});

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
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
        widget.onDestClick != null ? widget.onDestClick!(index) : null;
      },
      indicatorColor: Colors.transparent,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.search, color: BottomNav.selectedColor),
          icon: Icon(
            Icons.search,
            color: BottomNav.unselectedColor,
          ),
          label: 'Explore',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.email, color: BottomNav.selectedColor),
          icon: Icon(
            Icons.email_outlined,
            color: BottomNav.unselectedColor,
          ),
          label: 'Home',
        ),
        NavigationDestination(
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
      ],
    );
  }
}
