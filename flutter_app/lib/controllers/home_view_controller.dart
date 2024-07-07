import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/models/chat_card_model.dart';
import 'package:groupiq_flutter/services/groupiq_chat_service.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class HomeViewController {
  final groupiqChatService = GetIt.instance<GroupiqChatService>();
  final StreamController<List<ChatCardModel>> _recentGroupiqsController =
      StreamController.broadcast();
  Stream<List<ChatCardModel>> get recentGroupiqsStream =>
      _recentGroupiqsController.stream;
  final pb = GetIt.instance<PocketBaseService>().pb;

  init() async {
    final groupiqs = await getChatPage();

    List<ChatCardModel> chatCards = groupiqs
        .map((record) => ChatCardModel.fromRecordModel(record))
        .toList();
    _recentGroupiqsController.add(chatCards);

    pb.collection('groupiqs').subscribe('*', (e) {
      if (e.action == "create" && e.record != null) {
        final chatCard = ChatCardModel.fromRecordModel(e.record!);
        _recentGroupiqsController.add([chatCard]);
      }
    });
  }

  dispose() async {
    _recentGroupiqsController.close();
    await pb.collection('groupiqs').unsubscribe('*');
  }

  Future<List<RecordModel>> getChatPage() async {
    return (await groupiqChatService.getChatPage()).items;
  }
}
