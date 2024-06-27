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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        shape:
            const Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // chat avatar
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "chat info");
                },
                child: const ChatAvatar(
                    borderRadius: 40.0, width: 45.0, height: 45.0)),
            // chat title and users
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "chat info");
                    },
                    child: const Text(
                      "Chat title",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text("14 mil active",
                      style: TextStyle(
                          fontSize: 15.0, color: Color.fromARGB(64, 0, 0, 0)))
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(CommunityMaterialIcons.rocket_launch,
                          color: Colors.white, size: 10.0),
                    ),
                    Text("10k",
                        style: TextStyle(color: Colors.white, fontSize: 16.0))
                  ]),
                ),
              ),
            ),
            const Icon(CommunityMaterialIcons.dots_horizontal)
          ],
        ));
  }

  String formatNumber(int number) {
    final NumberFormat format = NumberFormat.compact();
    return format.format(number);
  }
}
