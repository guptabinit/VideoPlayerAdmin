import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player_admin/views/home_screen.dart';
import 'package:video_player_admin/widgets/custom_button.dart';
import 'package:video_player_admin/widgets/text_field.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.offAll(() => const HomeScreen());
    } else {
      showSnack(res);
    }
  }

  Future<void> showSnack(res) {
    return showSnackBar(res, context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          "Video Player",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Hello Admin👋",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              36.heightBox,
              CustomTextField(
                controller: emailController,
                labelText: "Enter your email",
              ),
              12.heightBox,
              CustomTextField(
                controller: passwordController,
                labelText: "Enter your password",
                isPass: true,
              ),
              24.heightBox,
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    )
                  : CustomButton(
                      btnText: "Login",
                      onTap: loginUser,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
