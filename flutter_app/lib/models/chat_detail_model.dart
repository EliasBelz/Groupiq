import 'package:pocketbase/pocketbase.dart';

class ChatDetailModel {
  final String title;
  final String id;
  final int members;
  final String lastMessage;
  final DateTime expiresAt;
  final String description;

  ChatDetailModel({
    required this.title,
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.expiresAt,
    required this.description,
  });

  factory ChatDetailModel.fromRecordModel(RecordModel record) {
    final map = record.toJson();
    return ChatDetailModel(
      title: map['title'] ?? '',
      id: record.id,
      members: map['members'] ?? 10,
      lastMessage: map['last_message'] ?? 'This is the last message sent.',
      expiresAt: DateTime.tryParse(map['expires_at']) ?? DateTime.now(),
      description: map['description'] ?? 'Example description.',
    );
  }
}
