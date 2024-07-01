import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/services/pocketbase/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class Registry {
  final getIt = GetIt.instance;
  Future<void> setUp() {
    getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
    getIt.registerSingletonAsync<PocketBase>(() async {
      return await PBConnect(storage: LocalStorage(), local: true);
    });
    return getIt.allReady();
  }
}
