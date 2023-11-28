import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/widgets/steps_widget.dart';
import 'package:flutter_black_white/screens/account/login_screen.dart';
import 'package:flutter_black_white/screens/account/register_terms_use_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/vallidators/register_first_validator.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final registerFirstValidator = RegisterFirstValidator();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _titleRegister(),
            const SizedBox(height: 15.0),
            const StepsWidget(
              stepFirst: StatusStep.current,
            ),
            const SizedBox(height: 40.0),
            _fullNameField(),
            const SizedBox(height: 20.0),
            _emailField(),
            const SizedBox(height: 20.0),
            _passwordField(),
            const SizedBox(height: 10.0),
            _orPasswordLabel(),
            const SizedBox(height: 20.0),
            _buttondLogin(context),
            const SizedBox(height: 60.0),
            _orLabel(),
            const SizedBox(height: 40.0),
            _labelLogin(context),
          ],
        ),
      ),
    );
  }

  Widget _titleRegister() {
    return const Text(
      "Create an Account",
      style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _fullNameField() {
    return StreamBuilder<String>(
      stream: registerFirstValidator.fullNameStream,
      builder: (context, snapshot) {
        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.center,
          onChanged: registerFirstValidator.fullNameAdd,
          decoration: InputDecoration(
            hintText: "Full Name",
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
      }
    );
  }

  Widget _passwordField() {
    return StreamBuilder<String>(
      stream: registerFirstValidator.passwordStream,
      builder: (context, snapshot) {
        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.center,
          onChanged: registerFirstValidator.passwordAdd,
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
      }
    );
  }

  Widget _emailField() {
    return StreamBuilder<String>(
      stream: registerFirstValidator.emailStream,
      builder: (context, snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.center,
          onChanged: registerFirstValidator.emailAdd,
          decoration: InputDecoration(
            hintText: "Email",
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
      }
    );
  }

  Widget _buttondLogin(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerFirstValidator.submit,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(320, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: kSecondaryColor,
            disabledBackgroundColor: kSecondaryColor.withOpacity(0.5),
            disabledForegroundColor: Colors.white
          ),
          onPressed: snapshot.hasData && snapshot.data! ? () {
            Navigator.pushNamed(context, RegisterTermsUseScreen.pathScreen);
          } : null,
          child: const Text(
            "REGISTER",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }
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

  Widget _labelLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already registered?",
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginScreen.pathScreen);
          },
          child: const Text(
            "Log in here",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _orPasswordLabel() {
    return const Text("password must be at least 8 characters");
  }
}
