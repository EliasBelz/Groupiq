import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PocketBaseService {
  final PocketBase pocketBase;
  PocketBaseService({required this.pocketBase});

  bool get isSignedIn => pocketBase.authStore.isValid;

  Future<void> signOut() async {
    pocketBase.authStore.clear();
  }

  /// Sign in using email and password
  /// Note: username can be used in place of email
  Future<RecordAuth> signIn(
      {required String email, required String password}) async {
    return await pocketBase
        .collection('users')
        .authWithPassword(email, password);
  }

  Future<RecordModel> createUser(
      {required String username,
      required String email,
      required String password,
      required String passwordConfirm,
      required String name}) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "password": password,
      "passwordConfirm": passwordConfirm,
      "name": name,
    };
    return await pocketBase.collection('users').create(body: body);
  }

  getUser() {
    return pocketBase.authStore.model();
  }
}

Future<PocketBase> PBConnect(
    {required LocalStorage storage, local = true}) async {
  await dotenv.load(fileName: ".env");

  final pbHostUrl = dotenv.env['PB_HOST_URL'];
  final pbLocal = dotenv.env['PB_LOCAL'];

  final token = await storage.getToken();
  final customAuthStore = AsyncAuthStore(
    initial: token,
    save: storage.setToken,
    clear: storage.deleteToken,
  );

  if (local && pbLocal != null) {
    return PocketBase(pbLocal, authStore: customAuthStore);
  } else if (pbHostUrl != null) {
    return PocketBase(pbHostUrl, authStore: customAuthStore);
  } else {
    throw Exception('No PocketBase URL found');
  }
}
