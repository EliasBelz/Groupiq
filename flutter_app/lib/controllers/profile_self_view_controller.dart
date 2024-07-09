import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/providers/current_user_provider.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:groupiq_flutter/widgets/helpers/error_snackbar.dart';

class ProfileSelfViewController {
  final PocketBaseService pocketBaseService =
      GetIt.instance<PocketBaseService>();
  CurrentUserProvider currentUserNotifier =
      GetIt.instance<CurrentUserProvider>();

  ProfileSelfViewController();

  String username() {
    return currentUserNotifier.currentUser!.username;
  }

  String name() {
    return currentUserNotifier.currentUser!.name;
  }

  String email() {
    return currentUserNotifier.currentUser?.email ?? "your email";
  }

  String avatarLink() {
    return currentUserNotifier.currentUser!.avatarFile.toString();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await pocketBaseService.signOut();
      if (context.mounted) context.go('/login');
    } catch (e) {
      if (context.mounted) showErrorSnackBar(context, 'Something went Wrong!');
    }
  }
}
