import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/vallidators/recovery_password_validator.dart';


class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({super.key});

  @override
  State<ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  final recoveryPasswordValidator = RecoveryPasswordValidator();

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
            _emailField(),
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

  Widget _emailField() {
    return StreamBuilder<String>(
      stream: recoveryPasswordValidator.emailStream,
      builder: (context, snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: recoveryPasswordValidator.emailAdd,
          decoration: InputDecoration(
            hintText: "Email",
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
    return StreamBuilder<String>(
      stream: recoveryPasswordValidator.emailStream,
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
    return const Text("Your password will be sent to your email.");
  }
}
