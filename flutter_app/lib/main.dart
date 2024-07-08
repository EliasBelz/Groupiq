import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:groupiq_flutter/services/registry.dart';
import 'package:groupiq_flutter/views/main_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sets up all of our app's dependencies
  await Registry().setUp();
  await GetIt.instance<PocketBaseService>().setCurrentUser();
  runApp(MainView());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
