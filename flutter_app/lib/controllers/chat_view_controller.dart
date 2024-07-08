import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/models/message.dart';
import 'package:groupiq_flutter/models/user.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/groupiq_chat_service.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class ChatViewController {
  final String id;
  final pb = GetIt.instance<PocketBaseService>().pb;
  final User user = GetIt.instance<CurrentUserProvider>().currentUser!;
  final groupiqChatService = GetIt.instance<GroupiqChatService>();

  final StreamController<List<Message>> _messagesController =
      StreamController.broadcast();
  Stream<List<Message>> get messagesStream => _messagesController.stream;

  ChatViewController(this.id);

  Future<void> init() async {
    _messagesController.add(await getMessages());
    await pb.collection('messages').subscribe(
      '*',
      filter: 'groupiq_id = "$id"',
      expand: 'user_id',
      (e) {
        if (e.action == "create" && e.record != null) {
          final message = Message.fromExpandedMessageRecordModel(e.record!);
          _messagesController.add([message]);
        }
      },
    );
  }

  dispose() async {
    _messagesController.close();
    await pb.collection('messages').unsubscribe('*');
  }

  Future<RecordModel> sendMessage(String text) async {
    final body = <String, dynamic>{
      "user_id": user.id,
      "groupiq_id": id,
      "text": text
    };

    return await pb.collection('messages').create(body: body);
  }

  getMessages() async {
    final records = await pb
        .collection('groupiq_messages')
        .getFullList(sort: '-created', filter: 'id = "$id"');
    List<Message> messages =
        records.map((record) => Message.fromRecordModel(record)).toList();
    return messages;
  }
}
