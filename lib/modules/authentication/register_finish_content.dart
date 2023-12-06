import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/widgets/steps_widget.dart';
import 'package:flutter_black_white/screens/account/login_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';

class RegisterFinishContent extends StatefulWidget {
  const RegisterFinishContent({super.key});

  @override
  State<RegisterFinishContent> createState() => _RegisterFinishContentState();
}

class _RegisterFinishContentState extends State<RegisterFinishContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleRegister(),
            const SizedBox(height: 15.0),
            const StepsWidget(
              stepFirst: StatusStep.done,
              stepSecond: StatusStep.done,
              stepThird: StatusStep.done,
            ),
            const SizedBox(height: 40),
            _welcomeTo(),
            const SizedBox(height: 30),
            _imageWelcome(),
            const SizedBox(height: 25),
            const SizedBox(
              height: 40,
            ),
            _buttondRegister()
          ],
        ),
      ),
    );
  }

  Widget _imageWelcome() {
    return const Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Image(
        image: AssetImage('assets/registerTitle.png'),
      ),
    );
  }

  Widget _titleRegister() {
    return const Text(
      "Completed",
      style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _welcomeTo() {
    return const Text(
      "Welcome to",
      style: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  Widget _buttondRegister() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(320, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text(
        "ENTER",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.pathScreen, (route) => false);
      },
    );
  }
}
