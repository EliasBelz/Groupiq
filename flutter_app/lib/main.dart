import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/registry.dart';
import 'package:groupiq_flutter/views/main_view.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sets up all of our app's dependencies
  await Registry().setUp();
  runApp(MainView());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
