import 'package:pocketbase/pocketbase.dart';

class ChatCardModel {
  final String title;
  final String id;
  final String members;
  final String lastMessage;
  final DateTime expiresAt;
  final String description;

  ChatCardModel({
    required this.title,
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.expiresAt,
    required this.description,
  });

  factory ChatCardModel.fromRecordModel(RecordModel record) {
    final map = record.toJson();
    return ChatCardModel(
      title: map['title'] ?? '',
      id: record.id,
      members: map['members'] ?? '10K',
      lastMessage: map['last_message'] ?? 'This is the last message sent.',
      expiresAt: DateTime.tryParse(map['expires_at']) ?? DateTime.now(),
      description: map['description'] ?? 'Example description.',
    );
  }
}
