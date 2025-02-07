import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_card/chat_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyChatCard extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const EmptyChatCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        highlightColor: Colors.blue.withAlpha(50),
        onTap: () {
          if (onTap != null) {
            print('Tapped!');
            onTap!();
          }
        },
        child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 227, 226, 226)))),
            height: 105,
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ChatAvatar(height: 75.w, width: 75.w),
                  ),
                  Expanded(child: child)
                ],
              ),
            )),
      ),
    );
  }
}
