import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_top_nav.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ChatTopNav(
            title: 'FishTank',
            activeUsers: 1700,
            chatUrl: 'https://placehold.co/600x400.png'));
  }
}
