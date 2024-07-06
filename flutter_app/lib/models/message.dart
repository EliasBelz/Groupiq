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

  factory Message.fromRecordModel(RecordModel record) {
    return Message(
      id: record.data['message_id'] ?? '',
      text: record.data['message_text'] ?? '',
      posterName: record.data['username'] ?? '',
      posterId: record.data['user_id'] ?? '',
      isAdmin: record.data['isAdmin'] ?? false,
      timePosted: DateTime.tryParse(record.created) ?? DateTime.now(),
      reactions: record.data['reactions'] ?? {},
    );
  }
}
