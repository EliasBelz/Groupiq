import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/views/app_shell.dart';
import 'package:groupiq_flutter/views/chat_info_view.dart';
import 'package:groupiq_flutter/views/explore_view.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'package:groupiq_flutter/views/login_view.dart';
import 'package:groupiq_flutter/views/signup_view.dart';
import 'package:groupiq_flutter/views/profile_self_view.dart';
import 'package:groupiq_flutter/views/chat_view.dart';
import 'package:groupiq_flutter/views/verification_view.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late final bool isLoggedIn;
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    final pb = widget.pb;
    final currentUserProvider = widget.getIt<CurrentUserProvider>();

    isLoggedIn =
        pb.authStore.isValid && currentUserProvider.currentUser != null;

    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: isLoggedIn ? '/home' : '/login',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return AppShell(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  child: LoginView(),
                  transitionsBuilder: _slideTransitionBuilder,
                  transitionDuration: Duration(milliseconds: 300),
                );
              },
            ),
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  child: HomeView(),
                  transitionsBuilder: _slideTransitionBuilder,
                  transitionDuration: Duration(milliseconds: 300),
                );
              },
            ),
            GoRoute(
              path: '/explore',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  child: ExploreView(),
                  transitionsBuilder: _slideTransitionBuilder,
                  transitionDuration: Duration(milliseconds: 300),
                );
              },
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  child: ProfileSelfView(),
                  transitionsBuilder: _slideTransitionBuilder,
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
            ),
            GoRoute(
              path: '/chat/:id',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                    child: ChatView(
                      id: state.pathParameters['id']!,
                    ),
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
                  transitionDuration: Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginView(),
          routes: [
            GoRoute(
              path: 'signup',
              builder: (context, state) => const SignUpView(),
            ),
            GoRoute(
              path: 'verify',
              builder: (context, state) => const VerificationView(),
            ),
          ],
        ),
      ],
    );

    print("InitState: isLoggedIn = $isLoggedIn");
  }

  @override
  Widget build(BuildContext context) {
    print("Build MainView: isLoggedIn = $isLoggedIn");
    final Size screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      responsiveWidgets: const [],
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Groupiq',
          theme: ThemeData(
            textTheme: TextTheme(
                bodyMedium: GoogleFonts.nunitoSans(
                    fontSize: 15, fontWeight: FontWeight.w400),
                displayLarge: GoogleFonts.nunitoSans(
                    fontSize: 40, fontWeight: FontWeight.w700)),
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.light),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
            ),
            inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Color.fromRGBO(0, 115, 248, 1),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 185, 185))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(255, 185, 185, 1), width: 3.0)),
                errorStyle:
                    TextStyle(color: Color.fromARGB(255, 255, 185, 185))),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}

Widget _slideTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
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
