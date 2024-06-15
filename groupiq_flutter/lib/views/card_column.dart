import 'package:flutter/material.dart';

class CardColumn extends StatelessWidget {
  final List<Widget> children;
  const CardColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 1, color: Color.fromARGB(255, 227, 226, 226)))),
      child: Column(children: children),
    );
  }
}
