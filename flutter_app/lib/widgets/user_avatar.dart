import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  const UserAvatar({String? url, super.key})
      : imageUrl = url ?? 'https://via.placeholder.com/150';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 50, // Adjust the size as needed
    );
  }
}
