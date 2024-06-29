import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupiq_flutter/functions/pocketbase/pocketbase_helper.dart';
import 'package:groupiq_flutter/views/login_view.dart';
import 'package:groupiq_flutter/views/main_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pb = await PBConnect();

  runApp(MainView(pb: pb));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
