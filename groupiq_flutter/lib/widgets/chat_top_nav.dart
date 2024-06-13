import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ChatTopNav extends StatelessWidget {
  final String title; // title of groupiq to display
  final String chatUrl;
  final int activeUsers;

  const ChatTopNav(
      {Key? key,
      this.title = 'Groupiq',
      this.chatUrl = 'https://placehold.co/300x300.png',
      this.activeUsers = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.only(
          left: 10.0, top: 20.0, right: 20.0, bottom: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 227, 226, 226),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              CommunityMaterialIcons.chevron_left,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 35,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(63, 0, 0, 0),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              chatUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 45,
                        width: 45,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                          child: Icon(CommunityMaterialIcons.check_decagram,
                              color: Color.fromARGB(255, 86, 160, 244),
                              size: 20.0),
                          margin: EdgeInsets.only(left: 5.0))
                    ]),
                    Text(
                      formatNumber(activeUsers) +
                          " active", // active number of users
                      style: TextStyle(
                          color: Color.fromARGB(126, 0, 0, 0), fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Icon(
              CommunityMaterialIcons.dots_horizontal,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  String formatNumber(int number) {
    final NumberFormat format = NumberFormat.compact();
    return format.format(number);
  }
}
