import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

enum StatusStep { done, current, none }

class StepsWidget extends StatelessWidget {
  final StatusStep stepFirst;
  final StatusStep stepSecond;
  final StatusStep stepThird;

  const StepsWidget({super.key, this.stepFirst = StatusStep.none, this.stepSecond = StatusStep.none, this.stepThird = StatusStep.none});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.20, right: size.width * 0.20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stepWidget("1", stepFirst),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            child: Divider(color: kSecondaryColor, thickness: 2.5),
          ),
          const SizedBox(
            width: 5,
          ),
          _stepWidget("2", stepSecond),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            child: Divider(color: kSecondaryColor, thickness: 2.5),
          ),
          const SizedBox(
            width: 5,
          ),
          _stepWidget("3", stepThird),
        ],
      ),
    );
  }

  Widget _stepWidget(String number, StatusStep step) {
    Decoration? cDecoration;
    Widget? child;

    switch (step) {
      case StatusStep.current:
        child = Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
        break;
      case StatusStep.done:
        child = const Center(
            child: Icon(
          Icons.check,
          color: Colors.white,
        ));
        break;
      case StatusStep.none:
        cDecoration = BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 3),
        );
        child = Center(
          child: Text(
            number,
            style: const TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );        
        break;
      default:
    }

    return Container(width: 30, height: 30, color: cDecoration == null ? kSecondaryColor : null, decoration: cDecoration, child: child);
  }
}
