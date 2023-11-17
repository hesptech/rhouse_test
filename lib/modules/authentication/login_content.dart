import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/screens.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/vallidators/login_validator.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final loginValidator = LoginValidator();

  @override
  void dispose() {
    loginValidator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _emailField(),
            const SizedBox(height: 20.0),
            _passwordField(),
            const SizedBox(height: 20.0),
            _buttondLogin(context),
            const SizedBox(
              height: 30,
            ),
            _labelForgotPassword(context),
            const SizedBox(height: 40.0),
            _orLabel(),
            const SizedBox(height: 40.0),
            _labelRegister(context),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return StreamBuilder<String>(
        stream: loginValidator.passwordStream,
        builder: (context, snapshot) {
          return TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.center,
            onChanged: loginValidator.passwordAdd,
            decoration: InputDecoration(
              hintText: "Password",
              errorText: snapshot.error?.toString(),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          );
        });
  }

  Widget _emailField() {
    return StreamBuilder<String>(
        stream: loginValidator.emailStream,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
            onChanged: loginValidator.emailAdd,
            decoration: InputDecoration(
              errorText: snapshot.error?.toString(),
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
        });
  }

  Widget _labelForgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ForgotPasswordScreen.pathScreen);
      },
      child: const Text(
        "Forgot your password",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _labelRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    return const Row(
      children: [
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

  Widget _buttondLogin(BuildContext context) {
    return StreamBuilder<bool>(
        stream: loginValidator.submit,
        builder: (context, snapshot) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(320, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: kSecondaryColor.withOpacity(0.5),
              disabledForegroundColor: Colors.white,
              backgroundColor: kSecondaryColor,
            ),
            onPressed: snapshot.hasData && snapshot.data!
                ? () {
                    Navigator.pushNamed(context, AccountScreen.pathScreen);
                  }
                : null,
            child: const Text(
              "LOG IN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
