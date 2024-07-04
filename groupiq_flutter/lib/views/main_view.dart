import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/views/app_shell.dart';
import 'package:groupiq_flutter/views/chat_info_view.dart';
import 'package:groupiq_flutter/views/explore_view.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'package:groupiq_flutter/views/login_view.dart';
import 'package:groupiq_flutter/views/profile_self_view.dart';
import 'package:groupiq_flutter/views/chat_view.dart';
import 'package:pocketbase/pocketbase.dart';

class MainView extends StatefulWidget {
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
    final Size screenSize = MediaQuery.of(context).size;
    final pb = widget.pb;
    final isLoggedIn = pb.authStore.isValid;
    final GlobalKey<NavigatorState> rootNavigatorKey =
        GlobalKey<NavigatorState>();

    print(
        'Device Width: ${screenSize.width}, Device Height: ${screenSize.height}');

    final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: isLoggedIn ? '/home' : '/login',
      routes: [
        ShellRoute(
          // navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return AppShell(child: child);
          },

          /// Shell Routes
          routes: [
            GoRoute(
                path:
                    '/', // Made the default route the login view because it felt safer?
                pageBuilder: (context, state) {
                  return const CustomTransitionPage<void>(
                      child: LoginView(),
                      transitionsBuilder: _slideTransitionBuilder,
                      transitionDuration: Duration(milliseconds: 300));
                }),
            GoRoute(
                path: '/home',
                pageBuilder: (context, state) {
                  return const CustomTransitionPage<void>(
                      child: HomeView(),
                      transitionsBuilder: _slideTransitionBuilder,
                      transitionDuration: Duration(milliseconds: 300));
                }),
            GoRoute(
                path: '/explore',
                pageBuilder: (context, state) {
                  return const CustomTransitionPage<void>(
                      child: ExploreView(),
                      transitionsBuilder: _slideTransitionBuilder,
                      transitionDuration: Duration(milliseconds: 300));
                }),
            GoRoute(
                path: '/profile',
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                      child: ProfileSelfView(),
                      transitionsBuilder: _slideTransitionBuilder,
                      transitionDuration: const Duration(milliseconds: 300));
                }),
            GoRoute(
              path: '/chat',
              pageBuilder: (context, state) {
                return const CustomTransitionPage<void>(
                    child: ChatView(),
                    transitionsBuilder: _slideTransitionBuilder,
                    transitionDuration: Duration(milliseconds: 300));
              },
            ),
            GoRoute(
              path: '/chat_info',
              pageBuilder: (context, state) {
                return const CustomTransitionPage<void>(
                    child: ChatInfoView(),
                    transitionsBuilder: _slideTransitionBuilder,
                    transitionDuration: Duration(milliseconds: 300));
              },
            ),
          ],
        ),

        /// Full screen routes
        GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      ],
    );

    return ScreenUtilInit(
        // this is according to our figma
        designSize: const Size(428, 926),
        // Whether to adapt the text according to the minimum of width and height
        minTextAdapt: true,
        // I think we set this to a list of widget names that we want to be responsive/rebuilt
        //^ actually this might be the opposite. Per the docs:
        // ark widget needs build only if:... responsiveWidgets does not contains widget name
        responsiveWidgets: const [],
        builder: (context, child) {
          return MaterialApp.router(
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
              routerConfig: router);
        });
  }
}

Widget _slideTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  const begin = Offset(1.0, 0.0); // Slide from right
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
