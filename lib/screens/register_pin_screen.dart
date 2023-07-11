import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/pin_verify_content.dart';

class RegisterPinScreen extends StatelessWidget {
  static String pathScreen = "registerPinScreen";

  const RegisterPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: const Text('Sign Up'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 34,
              )),
        ),
        body: const SafeArea(child: PinVerifyContent()));
  }
}