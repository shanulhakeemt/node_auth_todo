import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:node_auth_todo/core/providers/current_user_notifier.dart';
import 'package:node_auth_todo/core/theme/app_pallete.dart';
import 'package:node_auth_todo/features/auth/view/pages/login_page.dart';
import 'package:node_auth_todo/features/auth/viewmodel/auth_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void signOut(WidgetRef ref, BuildContext context) {
    ref.read(authViewModelProvider.notifier).clearSharedPreference();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );

    ref.read(currentUserNotifierProvider.notifier).removeUser();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Home Screen",
            style: TextStyle(color: Pallete.whiteColor, fontSize: 25),
          ),
          IconButton(
              onPressed: () => signOut(ref, context),
              icon: const Icon(
                Icons.logout,
                size: 24,
                color: Pallete.whiteColor,
              ))
        ],
      ),
    );
  }
}
