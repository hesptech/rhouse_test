import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/widgets/steps_widget.dart';
import 'package:flutter_black_white/providers/account/register_pin_provider.dart';
import 'package:flutter_black_white/screens/account/register_finish_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';

class PinVerifyContent extends StatefulWidget {
  const PinVerifyContent({super.key});

  @override
  State<PinVerifyContent> createState() => _PinViewState();
}

class _PinViewState extends State<PinVerifyContent> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final registerPinProvider = RegisterPinProvider();
  String error = '';
  final List<int> listPins = List<int>.generate(4, (index) => index);
  final List<bool> listHasErros = List<bool>.generate(4, (index) => false);

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


    var pinAdd = registerPinProvider.getPinAdd(index);
    pinAdd(value);

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
            const SizedBox(
              height: 40,
            ),
            _buttondRegister(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textsPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...listPins.map(
              (i) => SizedBox(
                width: 60,
                child: StreamBuilder<String>(
                    stream: registerPinProvider.getPinStream(i),
                    builder: (context, snapshot) {
                      
                      if (snapshot.hasError) {
                        listHasErros[i] = true;
                      } else {
                        listHasErros[i] = false;
                      }

                      registerPinProvider.pinValidationAdd(snapshot.data ?? "");


                      return TextField(
                        controller: _controllers[i],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 1,
                        onChanged: (value) => _onTextChanged(i, value),
                        focusNode: _focusNodes[i],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                          errorText: snapshot.hasError ? '' : null,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: kClTxtInputFieldLog, width: 2)),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
        StreamBuilder<String>(
              stream: registerPinProvider.pinValidationStream,
              builder: ((context, snapshot) {
                var existError = listHasErros.contains(true);

                return Visibility(
                  visible: existError,
                  child: const Text(
                    "Enter a valid value",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                );
              })),
      ],
    );
  }

  Widget _labelSubtitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    return const Text(
      "CODE",
      style: TextStyle(color: kClTxtInputFieldLog, fontWeight: FontWeight.w600),
    );
  }

  Widget labelPinBottom() {
    return const Text(
      "Enter 4 digit code",
      style: TextStyle(color: kClTxtInputFieldLog),
    );
  }

  Widget _buttondRegister() {
    return StreamBuilder<bool>(
        stream: registerPinProvider.registerPinValidator.submit,
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
                disabledForegroundColor: Colors.white),
            onPressed: snapshot.hasData && snapshot.data!
                ? () {
                    Navigator.pushNamed(context, RegisterFinishScreen.pathScreen);
                  }
                : null,
            child: const Text(
              "REGISTER",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
