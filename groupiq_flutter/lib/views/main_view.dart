import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final Size screenSize = MediaQuery.of(context).size;

    print(
        'Device Width: ${screenSize.width}, Device Height: ${screenSize.height}');

    return ScreenUtilInit(
        // this is according to our figma
        designSize: const Size(428, 926),
        // Whether to adapt the text according to the minimum of width and height
        minTextAdapt: true,
        // I think we set this to a list of widget names that we want to be responsive/rebuilt
        //^ actually this might be the opposite. Per the docs:
        // ark widget needs build only if:... responsiveWidgets does not contains widget name
        responsiveWidgets: [],
        builder: (context, child) {
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
                // floatingActionButton: FloatingActionButton(
                //   shape: const CircleBorder(),
                //   onPressed: () {
                //     print('FAB pressed');
                //   },
                //   child: const Icon(Icons.add, color: Colors.white),
                // );
              ));
        });
  }
}
