import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ChangePasswordContent extends StatelessWidget {
  const ChangePasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              _titleName(),
              _titleEmail(),
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
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Enter new password",
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

  Widget _titleName() {
    return const Center(
      child: Text(
        "Pepito Perez",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _titleEmail() {
    return const Center(
      child: Text(
        "pepito@email.com",
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
    return const Text("password must be at least 8 characters");
  }  

}
