import 'package:flutter/material.dart';
import 'package:node_auth_todo/core/theme/app_pallete.dart';
import 'package:node_auth_todo/core/widgets/custom_field.dart';
import 'package:node_auth_todo/features/auth/model/user_model.dart';
import 'package:node_auth_todo/features/auth/view/pages/login_page.dart';
import 'package:node_auth_todo/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:node_auth_todo/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  "Sign Up.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomField(
                  controller: nameController,
                  hintText: "Name",
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomField(
                  controller: emailController,
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomField(
                  controller: passController,
                  isObscuredText: true,
                  hintText: "PassWord",
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthGradientButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      ref.read(authViewModelProvider.notifier).signUpUser(
                          UserModel(
                              id: '',
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passController.text.trim(),
                              token: ''));
                    }
                  },
                  buttonText: "Sign up",
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                        TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold))
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
