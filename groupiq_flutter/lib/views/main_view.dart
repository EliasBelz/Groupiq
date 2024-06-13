import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groupiq_flutter/views/explore_view.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'package:groupiq_flutter/views/profile_view.dart';
import 'package:groupiq_flutter/widgets/bottom_nav.dart';
import 'package:groupiq_flutter/views/chat_view.dart';

class MainView extends StatefulWidget {
  static const views = <Widget>[
    const ExploreView(),
    const HomeView(),
    // const ChatView(),
    const ProfileView(),
  ];
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int currentPageIndex;

  @override
  void initState() {
    // Launches on home view
    currentPageIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Groupiq',
        theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.light),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: MainView.views[currentPageIndex],
            bottomNavigationBar: BottomNav(
              startingIdx: currentPageIndex,
              onDestClick: (idx) {
                setState(() {
                  currentPageIndex = idx;
                });
              },
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                print('FAB pressed');
              },
              child: const Icon(Icons.add, color: Colors.white),
            )));
  }
}
