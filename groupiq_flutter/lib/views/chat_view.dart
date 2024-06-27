import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:groupiq_flutter/models/message.dart';
import 'package:groupiq_flutter/widgets/chat_card/chat_avatar.dart';
import 'package:groupiq_flutter/widgets/chat_top_nav.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Message> messages = [
    Message(
      id: 1,
      text: "Hello",
      posterName: "Xx_fishlover_xX",
      posterId: 123457,
      isAdmin: false,
    ),
    Message(
      id: 2,
      text: "This is a longer message.  I think it's nice.",
      posterName: "marina",
      posterId: 123456,
      isAdmin: false,
    ),
  ];

  void addMessage(String message) {
    Message newMessage = Message(
        id: message.length + 1,
        text: message,
        posterName: "marina",
        posterId: 123456,
        isAdmin: false);

    setState(() {
      messages.add(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatTopNav(),
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageWidget(message: messages[index]);
                  },
                ),
              ),
            ),
          ),
          InputBar(
            onSend: (message) {
              addMessage(message);
            },
          ),
        ],
      ),
    );
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
  bool isTyping = false;

  void _send() {
    if (_controller.text.isNotEmpty) {
      widget.onSend(_controller.text);
      _controller.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                top: const BorderSide(width: 1.0, color: Colors.black26))),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.gif_box,
                    color: Colors.black54, size: 30.0),
                onPressed: () {
                  print("Post Gif");
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      filled: true,
                      fillColor: Color.fromARGB(255, 232, 238, 249),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 1.0),
                      ),
                      hintText: "Enter your message",
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: -30 * math.pi / 180,
                child: IconButton(
                  icon: Icon(
                    CommunityMaterialIcons.send_circle_outline,
                    size: 30.0,
                    color: isTyping ? Colors.blue : Colors.black26,
                  ),
                  onPressed: _send,
                ),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0, color: Colors.black26),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black54),
                          children: [
                        TextSpan(
                            text: "${message.posterName}: ",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: message.text)
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(DateFormat('HH:mm').format(message.timePosted),
                        style: const TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            )));
  }
}
