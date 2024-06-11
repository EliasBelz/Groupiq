import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/search_bar.dart';
import 'package:groupiq_flutter/widgets/tag_pill.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomSearchBar(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(child: Text('Explore page')),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('🔥 Trending Now',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
