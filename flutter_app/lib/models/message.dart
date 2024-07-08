// This class represents a single message from a user on the service
import 'package:pocketbase/pocketbase.dart';

class Message {
  final String id;
  final String text;
  final String posterName;
  final String posterId;
  final bool isAdmin;
  final DateTime timePosted;
  final Map<String, int> reactions; // this'll be like "=D": 12

  Message(
      {required this.id,
      required this.text,
      required this.posterName,
      required this.posterId,
      this.isAdmin = false,
      DateTime? timePosted,
      this.reactions = const {}})
      : timePosted = timePosted ?? DateTime.now();

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['message_id'] ?? '',
      text: map['message_text'] ?? '',
      posterName: map['username'] ?? '',
      posterId: map['user_id'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      timePosted: DateTime.tryParse(map['created']) ?? DateTime.now(),
      reactions: map['reactions'] ?? {},
    );
  }

  factory Message.fromExpandedMessageRecordModel(RecordModel record) {
    final map = record.toJson();
    return Message(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      posterName: map['expand']['user_id']['username'] ?? '',
      posterId: map['user_id'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      timePosted: DateTime.tryParse(map['created']) ?? DateTime.now(),
      reactions: map['reactions'] ?? {},
    );
  }

  factory Message.fromRecordModel(RecordModel record) {
    return Message.fromMap(record.toJson());
  }
}
