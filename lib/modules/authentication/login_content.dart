import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/register_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _emailField(),
          const SizedBox(height: 20.0),
          _passwordField(),
          const SizedBox(height: 20.0),
          _buttondLogin(),
          const SizedBox(height: 60.0),
          _orLabel(),
          const SizedBox(height: 40.0),
          _labelRegister(context),
        ],
      ),
    );
  }


  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _labelRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text(
          "New user?",
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegisterScreen.pathScreen);
          },
          child: const Text(
            "Sign up here",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _orLabel() {
    return Row(
      children: const [
        Expanded(
          child: Divider(color: kPrimaryColor, thickness: 1.3),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('or', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600, fontSize: 15)),
        ),
        Expanded(
          child: Divider(color: kPrimaryColor, thickness: 1.3),
        ),
      ],
    );
  }

  Widget _buttondLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(320, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text("LOG IN", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed: () {},
    );
  }

}
