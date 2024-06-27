import 'package:flutter/material.dart';
import 'package:groupiq_flutter/views/chat_view.dart';
import 'package:groupiq_flutter/widgets/chat_card/empty_chat_card.dart';

class ExploreChatCard extends StatelessWidget {
  const ExploreChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyChatCard(
        onTap: () {
          Navigator.pushNamed(context, 'chat');
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('FishTank', style: TextStyle(fontSize: 18)),
              ],
            ),
            Center(
              child: Icon(
                // Rounded or sharp better?
                Icons.chevron_right_rounded,
                size: 50,
                color: Colors.grey,
              ),
            )
          ],
        ));
  }
}
