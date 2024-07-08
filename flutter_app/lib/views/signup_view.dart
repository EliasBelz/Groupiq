import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:groupiq_flutter/widgets/helpers/error_snackbar.dart';
import 'dart:math';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  late final PocketBaseService pocketBaseService;
  final GetIt getIt = GetIt.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showAdditionalFields = false;

  late AnimationController _slideInAnimController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    pocketBaseService = getIt<PocketBaseService>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pocketBaseService.isSignedIn) {
        context.go('/home');
      }
    });

    _slideInAnimController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideInAnimController,
      curve: Curves.easeInOut,
    ));

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _slideInAnimController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle customBodyMediumStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    TextStyle customDisplayLargeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 115, 248, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: const AssetImage("assets/images/signup-bg.png"),
          fit: BoxFit.cover,
        )),
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Sign Up",
                            style: customDisplayLargeStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            "We don’t need that much to get started- just a password and an email to confirm you’re a real person.",
                            style: customBodyMediumStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: customBodyMediumStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              if (_showAdditionalFields)
                                SlideTransition(
                                  position: _offsetAnimation,
                                  child: AnimatedOpacity(
                                    opacity: _showAdditionalFields ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            style: customBodyMediumStyle,
                                            decoration: const InputDecoration(
                                              labelText: 'Password',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              } else if (value !=
                                                  _passwordConfirmController
                                                      .value.text
                                                      .toString()) {
                                                return 'Passwords must match!';
                                              }
                                              return null;
                                            },
                                            obscureText: true,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              controller:
                                                  _passwordConfirmController,
                                              style: customBodyMediumStyle,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Confirm Password'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a password';
                                                } else if (value !=
                                                    _passwordController
                                                        .value.text) {
                                                  return 'Passwords must match!';
                                                }

                                                return null;
                                              },
                                              obscureText: true,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                !_showAdditionalFields) {
                              setState(() {
                                _showAdditionalFields = true;
                              });

                              _slideInAnimController.forward();
                            } else {
                              try {
                                Random random = Random();
                                String userId =
                                    "user${Random().nextInt(999999).toString().padLeft(6, '0')}";

                                await pocketBaseService.createUser(
                                    username: userId,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    passwordConfirm:
                                        _passwordConfirmController.text,
                                    name: "Groupiq User");

                                if (context.mounted) {
                                  context.go('/login/verify');
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showErrorSnackBar(context,
                                      'Invalid sign up ${e.toString()}');
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
                            child: Text(
                                _showAdditionalFields ? "Sign Up" : "Next!",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromRGBO(86, 144, 255, 1))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
