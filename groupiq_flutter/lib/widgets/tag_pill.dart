import 'package:flutter/material.dart';

class TagPill extends StatelessWidget {
  final String text;
  final Color textColor;
  final Gradient gradient;
  final double height;
  final double width;
  final bool hasShadow;
  final double fontSize;

  const TagPill(
      {this.text = "",
      this.textColor = Colors.white,
      this.height = 25,
      this.width = 75,
      this.hasShadow = false,
      this.fontSize = 13,
      required this.gradient,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.45),
                    spreadRadius: 1,
                    blurRadius: 2.5,
                    offset: const Offset(0, 3.5),
                  ),
                ]
              : null,
        ),
        // This feels maybe dirty?? But it works
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
