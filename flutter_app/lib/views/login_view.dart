import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:groupiq_flutter/widgets/helpers/error_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GetIt getIt = GetIt.instance;
  late final CurrentUserProvider currentUserProvider;
  late final PocketBaseService pocketBaseService;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    pocketBaseService = getIt<PocketBaseService>();
    currentUserProvider = getIt<CurrentUserProvider>();
    // Idk if this is good form or not
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentUserProvider.currentUser != null) {
        context.go('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle customBodyMediumStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    TextStyle customDisplayLargeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 115, 248, 1),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: const AssetImage("assets/images/login-bg.png"),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Log In",
                    style: customDisplayLargeStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Before you start using Groupiq, you’ll need to log in",
                    style: customBodyMediumStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        style: customBodyMediumStyle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username or email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username or Email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        style: customBodyMediumStyle,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? CommunityMaterialIcons.eye_outline
                                    : CommunityMaterialIcons.eye_off_outline),
                                color: Colors.white)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await pocketBaseService.signIn(
                            email: _usernameController.text,
                            password: _passwordController.text);
                        if (context.mounted) {
                          context.go('/home');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showErrorSnackBar(context, 'Invalid login');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 10.0),
                    child: Text('Log in',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(86, 144, 255, 1))),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      context.go('/login/signup');
                    },
                    child: Text("Don't have an account?  Sign up!",
                        style: customBodyMediumStyle))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
