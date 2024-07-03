import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagPill extends StatelessWidget {
  final String text;
  final Color textColor;
  final Gradient gradient;
  final double height;
  final double width;
  final bool hasShadow;
  final double fontSize;

  TagPill({
    this.text = "",
    this.textColor = Colors.white,
    double height = 25.0,
    double width = 78.0,
    this.hasShadow = false,
    double fontSize = 12.0,
    required this.gradient,
    super.key,
  })  : height = height.w,
        width = width.w,
        fontSize = fontSize.sp;

  // TODO: Automatic resize
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
  }
}
