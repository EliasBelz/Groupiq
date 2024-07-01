import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase/pocketbase_service.dart';
import 'package:groupiq_flutter/views/chat_info_view.dart';
import 'package:groupiq_flutter/views/explore_view.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'package:groupiq_flutter/views/login_view.dart';
import 'package:groupiq_flutter/views/profile_view.dart';
import 'package:groupiq_flutter/widgets/bottom_nav.dart';
import 'package:groupiq_flutter/views/chat_view.dart';
import 'package:pocketbase/pocketbase.dart';

class MainView extends StatefulWidget {
  // lookup routes
  static final viewMap = <String, Widget>{
    "home": const HomeView(),
    "explore": const ExploreView(),
    "profile": ProfileView(),
    "chat": const ChatView(),
    "chat info": const ChatInfoView(),
    'login': const LoginView(),
  };
  late final PocketBase pb;
  final GetIt getIt = GetIt.instance;

  MainView({super.key}) {
    pb = getIt<PocketBase>();
  }

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    final Size screenSize = MediaQuery.of(context).size;
    final pb = widget.pb;

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
          final _isLoggedIn = pb.authStore.isValid;
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
                    Widget page = MainView.viewMap[settings.name] ??
                        (_isLoggedIn
                            ? const HomeView()
                            : const LoginView()); // change this to be whatever page ur working on
                    return MaterialPageRoute(builder: (_) => page);
                  },
                ),
                bottomNavigationBar: _isLoggedIn
                    ? BottomNav(
                        onDestClick: (screenName) {
                          navigatorKey.currentState?.pushNamed(screenName);
                        },
                      )
                    : null,
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
