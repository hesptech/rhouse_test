import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/vallidators/change_password_validator.dart';

class ChangePasswordContent extends StatefulWidget {
  const ChangePasswordContent({super.key});

  @override
  State<ChangePasswordContent> createState() => _ChangePasswordContentState();
}

class _ChangePasswordContentState extends State<ChangePasswordContent> {
  final changePasswordValidator = ChangePasswordValidator();

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
    return StreamBuilder<String>(
      stream: changePasswordValidator.passwordStream,
      builder: (context, snapshot) {
        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.center,
          onChanged: changePasswordValidator.passwordAdd,
          decoration: InputDecoration(
            hintText: "Enter new password",
            errorText: snapshot.error?.toString(),
            hintStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        );
      }
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
    return StreamBuilder<String>(
      stream: changePasswordValidator.passwordStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(double.maxFinite, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: kSecondaryColor.withOpacity(0.5),
            disabledForegroundColor: Colors.white,            
            backgroundColor: kSecondaryColor,
          ),
          onPressed: snapshot.hasData && !snapshot.hasError ? () {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          } : null,
          child: const Text(
            "SUBMIT",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        );
      }
    );
  }

  Widget _orPasswordLabel() {
    return const Text("password must be at least 8 characters");
  }
}
