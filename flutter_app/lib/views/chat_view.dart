import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/controllers/chat_view_controller.dart';
import 'package:groupiq_flutter/models/message.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:groupiq_flutter/widgets/chat_top_nav.dart';
import 'package:groupiq_flutter/widgets/helpers/error_snackbar.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ChatView extends StatefulWidget {
  // static const id = '660fqfqns4gbt3z'; Elias
  final id;
  const ChatView({required this.id, super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final pb = GetIt.instance<PocketBaseService>().pb;
  late final ChatViewController chatViewController;

  @override
  void initState() {
    chatViewController = ChatViewController(widget.id);
    chatViewController.init();
    super.initState();
  }

  @override
  void dispose() {
    chatViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = [];
    return Scaffold(
      appBar: const ChatTopNav(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: StreamBuilder<List<Message>>(
                stream: chatViewController
                    .messagesStream, // Assuming this is your Stream
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // TODO maybe do something else on error case
                    return endOfMessages();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return endOfMessages();
                  } else {
                    List<Message> newMessages = snapshot.data!;
                    messages.insertAll(0, newMessages);
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        return index == messages.length
                            ? endOfMessages() // Your method to indicate the end of messages
                            : MessageWidget(
                                message: messages[
                                    index]); // Your custom widget to display a message
                      },
                    );
                  }
                },
              ),
            ),
          ),
          InputBar(
            onSend: (message) async {
              try {
                chatViewController.sendMessage(message);
              } catch (e) {
                showErrorSnackBar(context, 'Message Failed to send.');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget endOfMessages() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.black45)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "No New Messages",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}

class InputBar extends StatefulWidget {
  final Function(String) onSend;

  const InputBar({super.key, required this.onSend});

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
            border: Border(top: BorderSide(width: 1.0, color: Colors.black26))),
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

  const MessageWidget({super.key, required this.message});

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
