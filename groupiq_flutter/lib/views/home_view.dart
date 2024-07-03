import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_card/card_column.dart';
import 'package:groupiq_flutter/widgets/dm_bar.dart';
import 'package:groupiq_flutter/widgets/chat_card/verbose_chat_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          DmBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('Recent Activity',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    )),
                CardColumn(children: [
                  VerboseChatCard(),
                  VerboseChatCard(),
                ]),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('All Groupiqs',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    )),
                CardColumn(children: [
                  VerboseChatCard(),
                  VerboseChatCard(),
                  VerboseChatCard(),
                  VerboseChatCard(),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
