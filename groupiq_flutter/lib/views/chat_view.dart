import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_card/chat_avatar.dart';
import 'package:groupiq_flutter/widgets/chat_top_nav.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<String> messages = [
    "WHAT",
    "Message 1 is a very long message.  What ",
    "How about other characters??? Другие языки???  我说中文很好."
  ];

  void addMessage(String message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatTopNav(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageWidget(message: messages[index]);
                },
              ),
            ),
            InputBar(
              onSend: (message) {
                addMessage(message);
              },
            ),
          ],
        ));
  }
}

class InputBar extends StatefulWidget {
  final Function(String) onSend;

  InputBar({required this.onSend});

  @override
  _InputBarState createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = TextEditingController();

  void _send() {
    if (_controller.text.isNotEmpty) {
      widget.onSend(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter your message",
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _send,
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
