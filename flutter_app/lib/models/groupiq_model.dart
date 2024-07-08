import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class GroupiqModel {
  final String id;
  final String title;
  final DateTime expiresAt;
  final String creatorId;
  final String description;
  final int members;
  final Uri banner;
  final Uri avatar;

  GroupiqModel(
      {required this.id,
      required this.title,
      required this.expiresAt,
      required this.creatorId,
      required this.description,
      required this.members,
      required this.banner,
      required this.avatar});

  factory GroupiqModel.fromRecordModel(RecordModel record) {
    final pocketBaseService = GetIt.instance<PocketBaseService>();

    Uri avatarLink = Uri(
      scheme: 'https',
      host: 'img.freepik.com',
      path: '/free-vector/blue-circle-with-white-user_78370-4707.jpg',
      query:
          't=st=1720130393~exp=1720133993~hmac=76659247ff25f36c759e98e271501f0ab6fe83b1bfe1e379b36cd78543786180&w=1380',
    );
    String recordAvatarFile = record.data['avatar'];
    if (recordAvatarFile != '') {
      avatarLink = pocketBaseService.getAvatar(record, recordAvatarFile);
    }

    Uri bannerLink = Uri(
      scheme: 'https',
      host: 'img.freepik.com',
      path: '/free-vector/blue-circle-with-white-user_78370-4707.jpg',
      query:
          't=st=1720130393~exp=1720133993~hmac=76659247ff25f36c759e98e271501f0ab6fe83b1bfe1e379b36cd78543786180&w=1380',
    );
    String recordBannerFile = record.data['banner'];
    if (recordAvatarFile != '') {
      avatarLink = pocketBaseService.getAvatar(record, recordBannerFile);
    }

    return GroupiqModel(
      id: record.id,
      title: record.data['title'] ?? '',
      expiresAt: DateTime.tryParse(record.data['expires_at']) ?? DateTime.now(),
      creatorId: record.data['creator_id'] ?? '',
      description: record.data['description'] ?? '',
      members: record.data['members'] ?? 10,
      banner: bannerLink,
      avatar: avatarLink,
    );
  }
}
