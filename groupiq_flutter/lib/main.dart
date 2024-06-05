import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupiq_flutter/views/home_view.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const HomeView());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
