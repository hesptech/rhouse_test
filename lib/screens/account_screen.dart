import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/account/account_content.dart';

class AccountScreen extends StatelessWidget {
  static String pathScreen = "account_screen";

  const AccountScreen({Key? key}) : super(key: key);

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
        body: const SafeArea(child: AccountContent()));
  }
}
