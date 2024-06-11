import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_avatar.dart';

class VerboseChatCard extends StatefulWidget {
  const VerboseChatCard({super.key});

  @override
  State<VerboseChatCard> createState() => _VerboseChatCardState();
}

class _VerboseChatCardState extends State<VerboseChatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(255, 227, 226, 226)))),
        height: 105,
        child: Center(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(width: 70, height: 70, child: ChatAvatar()),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                      child: Padding(
                        padding: EdgeInsets.only(top: 14.0, right: 7),
                        child: OverflowBox(
                          maxHeight: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // TODO: Make members dynamic
                            children: [
                              Text(
                                '10K',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Chat Name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text('Most recent message blah blah blah blah blah blah'),
                    // Expiry date
                    SizedBox(
                      height: 5,
                      child: OverflowBox(
                        maxHeight: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 22,
                              width: 114,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the Row items
                                  children: [
                                    // TODO make date dynamic
                                    Text(
                                      "10/03 11:20",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}