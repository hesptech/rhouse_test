import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/login_content.dart';
import 'package:flutter_black_white/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  static String pathScreen = "login_screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Log in'),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 34,
              )),        
      ),
      body: const SafeArea(child: LoginContent())
    );     
  }

}
