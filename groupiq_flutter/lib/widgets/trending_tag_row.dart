import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/tag_pill.dart';

class TrendingTagRow extends StatelessWidget {
  final List<String> tags;
  const TrendingTagRow({super.key, this.tags = const []});
  // TODO:
  // Make the TrendingTagRow widget accept a list of tags
  // The width of the TagPill should be based on the length of the tag
  // Maybe make tags horizontally scrollable if there are too many
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TagPill(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 252, 182, 70),
                Color.fromARGB(255, 239, 72, 22)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            hasShadow: true,
            text: '#phish'),
        TagPill(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 220, 85, 253),
                Color.fromARGB(255, 123, 22, 239)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            hasShadow: true,
            text: '#health'),
        TagPill(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 85, 253, 113),
                Color.fromARGB(255, 22, 170, 239)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            hasShadow: true,
            text: '#fitness',
            width: 85),
        TagPill(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 110, 85, 253),
                Color.fromARGB(255, 239, 22, 112)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            hasShadow: true,
            text: '#ipsum'),
      ],
    );
  }
}
