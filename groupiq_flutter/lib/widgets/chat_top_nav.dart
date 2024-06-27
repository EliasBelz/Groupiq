import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:groupiq_flutter/widgets/chat_card/chat_avatar.dart';
import 'package:intl/intl.dart';

class ChatTopNav extends StatelessWidget implements PreferredSizeWidget {
  const ChatTopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(children: [
        // chat avatar
        const ChatAvatar(borderRadius: 40.0, width: 45.0, height: 45.0),
        // chat title and users
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Chat title"), Text("14 mil active")],
          ),
        ),
        const Spacer(),
        Container(
          color: Colors.blue,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(children: [
              Icon(CommunityMaterialIcons.rocket_launch),
              Text("10k")
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(CommunityMaterialIcons.dots_horizontal),
        )
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String formatNumber(int number) {
    final NumberFormat format = NumberFormat.compact();
    return format.format(number);
  }
}
