import 'package:flutter/material.dart';
import 'package:node_auth_todo/core/theme/theme.dart';
import 'package:node_auth_todo/features/auth/view/pages/login_page.dart';

Future<void> main() async {
 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
