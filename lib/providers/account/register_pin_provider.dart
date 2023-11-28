import 'package:flutter_black_white/vallidators/register_pin_validator.dart';
import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class RegisterPinProvider extends ValidatorMain {
  final registerPinValidator = RegisterPinValidator();
  final _pinValidation = BehaviorSubject<String>();

  Stream<String> get pinValidationStream => _pinValidation.stream.transform(pinValidator);
  Function(String) get pinValidationAdd => _pinValidation.sink.add;
  String get pinValidationValue => _pinValidation.value;


  Stream<String> getPinStream(int pinValue) {
    if (pinValue == 1) {
      return registerPinValidator.pin1Stream;     
    }

    if (pinValue == 2) {
      return registerPinValidator.pin2Stream;
    }

    if (pinValue == 3) {
      return registerPinValidator.pin3Stream;
    }

      return registerPinValidator.pin4Stream;
  }

  Function(String) getPinAdd(int pinValue) {
    if (pinValue == 1) {
      return registerPinValidator.pin1Add;
    }

    if (pinValue == 2) {
      return registerPinValidator.pin2Add;
    }

    if (pinValue == 3) {
      return registerPinValidator.pin3Add;
    }

      return registerPinValidator.pin4Add;
  }

  String getPinValue(int pinValue) {
    if (pinValue == 1) {
      return registerPinValidator.pin1Value;
    }

    if (pinValue == 2) {
      return registerPinValidator.pin2Value;
    }

    if (pinValue == 3) {
      return registerPinValidator.pin3Value;
    }

      return registerPinValidator.pin4Value;  
  }
}
