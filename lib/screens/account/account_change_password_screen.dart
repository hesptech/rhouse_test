import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/account/change_password_content.dart';


class AccountChangePasswordScreen extends StatelessWidget {
  static String pathScreen = "accountChangePasword_Screen";

  const AccountChangePasswordScreen({super.key});

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
      resizeToAvoidBottomInset: true,
      body:  const SafeArea(child: ChangePasswordContent())
    );     
  }
}