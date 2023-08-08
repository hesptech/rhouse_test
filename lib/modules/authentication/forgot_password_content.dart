import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ForgotPasswordContent extends StatelessWidget {
  const ForgotPasswordContent({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              _title(),
              const SizedBox(
                height: 30,
              ),
              _passwordField(),
              const SizedBox(
                height: 15,
              ),
              _orPasswordLabel(),
              const SizedBox(
                height: 15,
              ),
              _buttondSubmit(context)
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _title() {
    return const Center(
      child: Text(
        "Enter your email address associated with your account",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buttondSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text(
        "SUBMIT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      },
    );
  }


  Widget _orPasswordLabel() {
    return const Text("Your password will be sent to your email.");
  }  
  
}