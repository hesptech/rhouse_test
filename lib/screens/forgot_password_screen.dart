import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/forgot_password_content.dart';


class ForgotPasswordScreen extends StatelessWidget {
  static String pathScreen = "forgotPassword_Screen";

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Account'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 34,
              )),        
      ),
      resizeToAvoidBottomInset: false,
      body:  const SafeArea(child: ForgotPasswordContent())
    );     
  }
}