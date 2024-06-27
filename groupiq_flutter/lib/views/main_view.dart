import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groupiq_flutter/views/explore_view.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'package:groupiq_flutter/views/profile_view.dart';
import 'package:groupiq_flutter/widgets/bottom_nav.dart';
import 'package:groupiq_flutter/views/chat_view.dart';

class MainView extends StatefulWidget {
  // lookup routes
  static const viewMap = <String, Widget>{
    "home": HomeView(),
    "explore": ExploreView(),
    "profile": ProfileView(),
    "chat": ChatView()
  };

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            body: Navigator(
              key: navigatorKey,
              onGenerateRoute: (settings) {
                print(settings.name);
                Widget page =
                    MainView.viewMap[settings.name] ?? const HomeView();
                return MaterialPageRoute(builder: (_) => page);
              },
            ),
            bottomNavigationBar: BottomNav(
              onDestClick: (screenName) {
                navigatorKey.currentState?.pushNamed(screenName);
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
