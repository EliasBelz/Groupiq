import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketbase/pocketbase.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final PocketBase pb;
  final GetIt getIt = GetIt.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late GlobalKey<FormState> _formKey;
  bool _isLogin = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    pb = getIt<PocketBase>();
    // Idk if this is good form or not
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pb.authStore.isValid) {
        context.go('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    setState(() {
      _isLogin = !_isLogin;
      // I feel like tou shouldn't have to do this, but the text fields don't clear otherwise
      // I did this to force a rerender
      _formKey = GlobalKey<FormState>();
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _signUp(
      {required String username,
      required String email,
      required String password,
      required String passwordConfirm,
      required String name}) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "password": password,
      "passwordConfirm": passwordConfirm,
      "name": name,
    };
    final record = await pb.collection('users').create(body: body);
    print(record);
  }

  _signIn({required String email, required String password}) async {
    final authData =
        await pb.collection('users').authWithPassword(email, password);
    print(authData);
    print(pb.authStore.isValid);
    if (mounted) {
      context.go('/home');
    }
  }

  // TODO show more detailed error messages -> i think you can just pull the status message from the response
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_isLogin) ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username${_isLogin ? ' or Email' : ''}'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length < 8 ||
                      value.length > 72) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              if (!_isLogin)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_isLogin) {
                      try {
                        await _signIn(
                            email: _usernameController.text,
                            password: _passwordController.text);
                      } catch (e) {
                        mounted
                            ? _showSnackBar(context, 'Invalid login')
                            : null;
                      }
                    } else {
                      try {
                        await _signUp(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            passwordConfirm: _confirmPasswordController.text,
                            name: _nameController.text);
                      } catch (e) {
                        mounted
                            ? _showSnackBar(context, 'Invalid sign up')
                            : null;
                      }
                    }
                  }
                },
                child: Text(_isLogin ? 'Login' : 'Create Account'),
              ),
              TextButton(
                onPressed: _toggleFormType,
                child: Text(_isLogin
                    ? 'Need an account? Sign up.'
                    : 'Have an account? Log in.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
