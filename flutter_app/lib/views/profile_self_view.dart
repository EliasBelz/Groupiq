import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileSelfView extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  final PocketBaseService pocketBaseService =
      GetIt.instance<PocketBaseService>();
  ProfileSelfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Spacer(),
        const Text('Profile page'),
        ElevatedButton(
          onPressed: () async {
            await pocketBaseService.signOut();
            if (context.mounted) {
              context.go('/login');
            }
          },
          child: const Text('Sign Out!'),
        ),
      ],
    ));
  }
}
