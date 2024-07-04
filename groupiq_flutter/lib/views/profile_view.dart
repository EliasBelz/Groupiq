import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GetIt getIt = GetIt.instance;
  final PocketBaseService pocketBaseService =
      GetIt.instance<PocketBaseService>();

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
            if (mounted) {
              context.go('/login');
            }
          },
          child: const Text('Sign Out!'),
        ),
      ],
    ));
  }
}
