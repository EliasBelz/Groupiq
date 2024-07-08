import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/models/chat_detail_model.dart';
import 'package:groupiq_flutter/services/groupiq_chat_service.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class HomeViewController {
  final groupiqChatService = GetIt.instance<GroupiqChatService>();
  final StreamController<List<ChatDetailModel>> _recentGroupiqsController =
      StreamController.broadcast();
  bool _isControllerClosed = false;

  Stream<List<ChatDetailModel>> get recentGroupiqsStream =>
      _recentGroupiqsController.stream;
  final pb = GetIt.instance<PocketBaseService>().pb;

  init() async {
    final groupiqs = await getChatPage();
    List<ChatDetailModel> chatCards = groupiqs
        .map((record) => ChatDetailModel.fromRecordModel(record))
        .toList();
    _safeAddEvent(chatCards);

    pb.collection('groupiqs').subscribe('*', (e) {
      if (e.action == "create" && e.record != null) {
        final chatCard = ChatDetailModel.fromRecordModel(e.record!);
        _safeAddEvent([chatCard]);
      }
    });
  }

  dispose() async {
    _recentGroupiqsController.close();
    _isControllerClosed = true;
    await pb.collection('groupiqs').unsubscribe('*');
  }

  Future<List<RecordModel>> getChatPage() async {
    return (await groupiqChatService.getChatPage()).items;
  }

  void _safeAddEvent(List<ChatDetailModel> chatCards) {
    if (!_isControllerClosed) {
      _recentGroupiqsController.add(chatCards);
    }
  }
}
