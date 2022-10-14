import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../services/auth_service.dart';
import 'package:get/get.dart';

enum Auth {
  sigin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    _emailController.text = "hu@gmail.com";
    _passwordController.text = "hung20112002";
    _nameController.text = "Nguyen minh Hung";
  }

  @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _nameController.dispose();
  //   super.dispose();
  // }

  void signUpUser() {
    authService.signUpUser(
      context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    isLoading.value = true;
    authService.signInUser(
      context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Well Come',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            ListTile(
              title: const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            (_auth == Auth.signup)
                ? Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _nameController, hintText: 'Name'),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          Obx(() => (isLoading.value)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue))
                              : CustomButton(
                                  text: 'Sign In',
                                  onTap: () {
                                    signInUser();
                                  },
                                ))
                        ],
                      ),
                    ),
                  ),
            ListTile(
              title: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.sigin,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
