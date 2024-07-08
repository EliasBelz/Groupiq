import 'package:flutter/material.dart';
import 'package:groupiq_flutter/controllers/home_view_controller.dart';
import 'package:groupiq_flutter/models/chat_detail_model.dart';
import 'package:groupiq_flutter/widgets/chat_card/card_column.dart';
import 'package:groupiq_flutter/widgets/dm_bar.dart';
import 'package:groupiq_flutter/widgets/chat_card/verbose_chat_card.dart';
import 'package:groupiq_flutter/widgets/helpers/error_snackbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController _homeViewController = HomeViewController();

  @override
  void initState() {
    _homeViewController.init();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ChatDetailModel> recentGroupiqs = [];
    return SingleChildScrollView(
      child: Column(
        children: [
          const DmBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('Recent Activity',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    )),
                StreamBuilder(
                    stream: _homeViewController.recentGroupiqsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // TODO maybe do something else on error case
                        showErrorSnackBar(
                            context, "Error loading recent groupiqs");
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No recent groupiqs'));
                      } else {
                        List<ChatDetailModel> newGroupiqs = snapshot.data!;
                        recentGroupiqs.insertAll(0, newGroupiqs);
                        // recentGroupiqs = recentGroupiqs.take(5).toList();
                        List<Widget> chatCards = recentGroupiqs
                            .map((model) => VerboseChatCard(model: model))
                            .toList();
                        return CardColumn(children: chatCards);
                      }
                    }),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('All Groupiqs',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    )),
                StreamBuilder(
                    stream: _homeViewController.recentGroupiqsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // TODO maybe do something else on error case
                        showErrorSnackBar(
                            context, "Error loading recent groupiqs");
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No recent groupiqs'));
                      } else {
                        // List<ChatCardModel> newGroupiqs = snapshot.data!;
                        // recentGroupiqs.insertAll(0, newGroupiqs);
                        // recentGroupiqs = recentGroupiqs.take(5).toList();
                        List<Widget> chatCards = recentGroupiqs
                            .map((model) => VerboseChatCard(model: model))
                            .toList();
                        return CardColumn(children: chatCards);
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
