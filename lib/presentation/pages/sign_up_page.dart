import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/presentation/widgets/input_field.dart';
import 'package:news_app/presentation/widgets/primary_button.dart';

import '../controllers/auth_controller.dart';

class SignUpPage extends GetView<AuthController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              InputField(
                controller: emailController,
                title: 'Email',
                hint: 'Enter your email address here',
              ),
              const SizedBox(height: 16),
              InputField(
                controller: passwordController,
                title: 'Password',
                hint: 'Enter your password here',
                isPassword: true,
              ),
              const SizedBox(height: 24),
              Obx(
                () => PrimaryButton(
                  text: "Sign Up",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.errorMessage.value = '';
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isNotEmpty && password.isNotEmpty) {
                      controller.signUp(email, password);
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill in all fields",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ),
              Obx(
                () =>
                    controller.errorMessage.value.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                        : Container(),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  controller.errorMessage.value = '';
                  Get.back();
                },
                child: const Text('Already have an account? Sign In'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
