import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/bottom_nav.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({required this.child, super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.child, bottomNavigationBar: const BottomNav());
  }
}
