import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/widgets/steps_widget.dart';
import 'package:flutter_black_white/screens/register_finish_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';

class PinVerifyContent extends StatefulWidget {
  const PinVerifyContent({super.key});

  @override
  State<PinVerifyContent> createState() => _PinViewState();
}

class _PinViewState extends State<PinVerifyContent> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }

    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              stepThird: StatusStep.none,
            ),
            const SizedBox(height: 20),
            _labelSubtitle(),
            const SizedBox(height: 30),
            _labelPin(),
            const SizedBox(height: 25),
            _textsPin(),
            const SizedBox(height: 20),
            labelPinBottom(),
            const SizedBox(height: 40,),
            _buttondRegister(),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _textsPin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 4; i++)
          SizedBox(
            width: 60,
            child: TextField(
              controller: _controllers[i],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 1,
              onChanged: (value) => _onTextChanged(i, value),
              focusNode: _focusNodes[i],
              textAlign: TextAlign.center,
              decoration:  InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: kClTxtInputFieldLog,
                    width: 2
                  )
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _labelSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Email Address:",
          style: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Text(
          "email@email.com",
          style: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          "We've sent a verification code to your email.",
          style: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _titleRegister() {
    return const Text(
      "Verify it’s you",
      style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _labelPin() {
    return const Text("CODE", style: TextStyle(color: kClTxtInputFieldLog, fontWeight: FontWeight.w600),);
  }

  Widget labelPinBottom() {
    return const Text("Enter 4 digit code", style: TextStyle(color: kClTxtInputFieldLog),);
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
      child: const Text("REGISTER", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pushNamed(context, RegisterFinishScreen.pathScreen);

      },
    );
  }  
}
