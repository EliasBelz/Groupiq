import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_card/card_column.dart';
import 'package:groupiq_flutter/widgets/chat_card/explore_chat_card.dart';
import 'package:groupiq_flutter/widgets/search_bar.dart';
import 'package:groupiq_flutter/widgets/tag_pill.dart';
import 'package:groupiq_flutter/widgets/trending_tag_row.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchBar(),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('🔥 Trending Now',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TrendingTagRow(),
                ),
                CardColumn(
                  children: [ExploreChatCard(), ExploreChatCard()],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('🌍 Around the World',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TrendingTagRow(),
                ),
                CardColumn(
                  children: [
                    ExploreChatCard(),
                    ExploreChatCard(),
                    ExploreChatCard(),
                    ExploreChatCard(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
