import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupiq_flutter/services/pocketbase/pocketbase_service.dart';
import 'package:groupiq_flutter/services/pocketbase/registry.dart';
import 'package:groupiq_flutter/views/login_view.dart';
import 'package:groupiq_flutter/views/main_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sets up all of our app's dependencies
  await Registry().setUp();

  runApp(MainView());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
