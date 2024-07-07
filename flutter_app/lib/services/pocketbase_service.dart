import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/models/user.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PocketBaseService {
  final PocketBase pb;
  final currentUserNotifier = GetIt.instance<CurrentUserProvider>();
  PocketBaseService({required this.pb});

  setCurrentUser() async {
    if (pb.authStore.isValid) {
      final currentUser = await getCurrentUser();
      currentUserNotifier.setUser(currentUser);
    } else {
      currentUserNotifier.setUser(null);
    }
  }

  bool get isSignedIn => pb.authStore.isValid;

  Future<void> signOut() async {
    pb.authStore.clear();
    currentUserNotifier.setUser(null);
  }

  /// Sign in using email and password
  /// Note: username can be used in place of email
  Future<RecordAuth> signIn(
      {required String email, required String password}) async {
    final record =
        await pb.collection('users').authWithPassword(email, password);
    currentUserNotifier.setUser(await getCurrentUser());
    return record;
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
    return await pb.collection('users').create(body: body);
  }

  /// Lazy way to get the current user
  /// Isn't guaranteed to be up to date
  getCurrentUserLazy() async {
    return User.fromMap(pb.authStore.model.data);
  }

  Future<User?> getCurrentUser() async {
    return await getUserById(pb.authStore.model.id);
  }

  Uri getAvatar(RecordModel record, String filename) {
    return pb.files.getUrl(record, filename);
  }

  Future<User?> getUserById(String id) async {
    try {
      return User.fromRecordModel((await pb.collection("users").getOne(id)));
    } catch (e) {
      return null;
    }
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
