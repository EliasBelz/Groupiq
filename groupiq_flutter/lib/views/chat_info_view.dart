import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupiq_flutter/widgets/chat_card/chat_avatar.dart';

class ChatInfoView extends StatefulWidget {
  const ChatInfoView({super.key});

  @override
  State<ChatInfoView> createState() => _ChatInfoViewState();
}

class _ChatInfoViewState extends State<ChatInfoView> {
  bool _stretch = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            stretch: _stretch,
            onStretchTrigger: () async {
              // Triggers when stretching
            },
            // [stretchTriggerOffset] describes the amount of overscroll that must occur
            // to trigger [onStretchTrigger]
            //
            // Setting [stretchTriggerOffset] to a value of 300.0 will trigger
            // [onStretchTrigger] when the user has overscrolled by 300.0 pixels.
            stretchTriggerOffset: 300.0,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(.0),
                      child: ChatAvatar(
                          height: 50.0, width: 50.0, borderRadius: 75.0),
                    ),
                    Text('FishTank',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("14 mil active",
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white70)),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: VerticalDivider(
                              color: Colors.white,
                              width: 10,
                              thickness: 1,
                            ),
                          ),
                          Text("2 bil members",
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white70))
                        ],
                      ),
                    )
                  ],
                ),
                background: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                            "https://s.itl.cat/pngfile/s/185-1857844_490-fish-hd-wallpapers-underwater-wallpaper-hd-1080p.jpg"),
                        fit: BoxFit.cover,
                      )),
                    ),
                    Container(
                      height: 350.0,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 86, 144, 255),
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Color.fromARGB(80, 86, 144, 255),
                                Color.fromARGB(255, 86, 144, 255),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    )
                  ],
                ))),
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height -
                  130, // height - height of bottom nav
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.black26),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('SCROLL DOWN'),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
