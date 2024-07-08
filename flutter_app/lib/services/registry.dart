import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/groupiq_chat_service.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class Registry {
  final getIt = GetIt.instance;
  Future<void> setUp() async {
    // Register all dependencies upfront
    getIt.registerSingleton<CurrentUserProvider>(CurrentUserProvider());
    getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
    final localStorage = getIt<LocalStorage>();
    final pocketBase = await PBConnect(storage: localStorage, local: false);
    getIt.registerSingleton<PocketBase>(pocketBase);
    final PocketBaseService pocketBaseService =
        PocketBaseService(pb: pocketBase);
    getIt.registerSingleton<PocketBaseService>(pocketBaseService);
    getIt.registerSingleton<GroupiqChatService>(GroupiqChatService());

    return getIt.allReady();
  }
}
