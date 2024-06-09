import 'package:flutter/material.dart';

class DmBar extends StatefulWidget {
  const DmBar({super.key});

  @override
  State<DmBar> createState() => _DmBarState();
}

class _DmBarState extends State<DmBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 100,
      child: const Center(
        child: Text('DM BAR'),
      ),
    );
  }
}
