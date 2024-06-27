import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final double borderRadius;
  final double height;
  final double width;

  const ChatAvatar(
      {super.key,
      this.borderRadius = 5.0,
      this.height = 100.0,
      this.width = 100.0});

  // const ChatAvatar({super.key});

  //TODO imageLoadBuilder
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
