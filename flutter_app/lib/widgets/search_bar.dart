import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        height: 120,
        child: const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Center(
              child: SizedBox(
            width: 350,
            height: 40,
            child: SearchBar(
              hintText: 'Search for rooms, or tags with \'#\'',
            ),
          )),
        ));
  }
}
