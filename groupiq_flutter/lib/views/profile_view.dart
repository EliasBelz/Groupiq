import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileView extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Spacer(),
        const Text('Profile page'),
        ElevatedButton(
          onPressed: () async {
            await getIt.get<LocalStorage>().deleteToken();
            getIt.get<PocketBase>().authStore.clear();
            // TODO IDK WHY THE BOTTOM NAV STICKS :-()
            context.go('/login');
          },
          child: const Text('Sign Out!'),
        ),
      ],
    ));
  }
}
