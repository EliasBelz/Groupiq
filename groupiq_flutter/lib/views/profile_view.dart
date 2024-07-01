import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/local_storage.dart';
import 'package:groupiq_flutter/views/main_view.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileView extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Spacer(),
        const Text('Profile page'),
        ElevatedButton(
          onPressed: () async {
            await getIt.get<LocalStorage>().deleteToken();
            getIt.get<PocketBase>().authStore.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                // TODO IDK WHY THE BOTTOM NAV STICKS :-()
                builder: (context) => MainView(),
              ),
            );
            ;
          },
          child: const Text('Sign Out!'),
        ),
      ],
    ));
  }
}
