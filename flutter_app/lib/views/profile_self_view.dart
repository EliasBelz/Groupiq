import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:groupiq_flutter/controllers/profile_self_view_controller.dart';
import 'package:groupiq_flutter/widgets/user_avatar.dart';

class ProfileSelfView extends StatelessWidget {
  final ProfileSelfViewController controller = ProfileSelfViewController();
  ProfileSelfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text('Profile page'),
        UserAvatar(url: controller.avatarLink()),
        Text(
          controller.name(),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '@${controller.username()}',
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await controller.signOut(context);
          },
          child: const Text('Sign Out!'),
        ),
      ],
    ));
  }
}
