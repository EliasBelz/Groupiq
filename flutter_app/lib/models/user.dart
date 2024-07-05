import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String bio;
  final String email;
  final Uri avatarFile;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.bio,
      required this.email,
      required this.avatarFile});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      avatarFile: map['avatar'] ?? '',
      bio: map['bio'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'bio': bio,
      'email': email,
      'avatar': avatarFile,
    };
  }

  factory User.fromRecordModel(RecordModel record) {
    Uri imageLink = Uri(
      scheme: 'https',
      host: 'img.freepik.com',
      path: '/free-vector/blue-circle-with-white-user_78370-4707.jpg',
      query:
          't=st=1720130393~exp=1720133993~hmac=76659247ff25f36c759e98e271501f0ab6fe83b1bfe1e379b36cd78543786180&w=1380',
    );
    String recordImgFile = record.data['avatar'];
    if (recordImgFile != '') {
      imageLink =
          GetIt.instance<PocketBaseService>().getAvatar(record, recordImgFile);
    }

    return User(
      id: record.id,
      name: record.data['name'] ?? '',
      username: record.data['username'] ?? '',
      bio: record.data['bio'] ?? '',
      email: record.data['email'] ?? '',
      avatarFile: imageLink,
    );
  }

  @override
  String toString() {
    return 'User(id:$id, name: $name, username: $username, bio: $bio, email: $email, avatarFile: $avatarFile)';
  }
}
