import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';

class ProfileViewController {
  final PocketBaseService pocketBaseService;
  GetIt getIt = GetIt.instance;
  ProfileViewController()
      : pocketBaseService = GetIt.instance<PocketBaseService>();
}
