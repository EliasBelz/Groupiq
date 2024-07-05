import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/providers/current_user_notifier.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class Registry {
  final getIt = GetIt.instance;
  Future<void> setUp() async {
    // Register all dependencies upfront
    getIt.registerSingleton<CurrentUserNotifier>(CurrentUserNotifier());
    getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
    // Retrieve the registered instance of LocalStorage
    final localStorage = getIt<LocalStorage>();
    final pocketBase = await PBConnect(storage: localStorage, local: true);

    getIt.registerSingleton<PocketBase>(pocketBase);
    getIt.registerSingleton<PocketBaseService>(
        PocketBaseService(pb: pocketBase));

    return getIt.allReady();
  }
}
