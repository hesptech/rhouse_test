import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordValidator extends ValidatorMain {
  final _passwordCtrl = BehaviorSubject<String>();

  Stream<String> get passwordStream => _passwordCtrl.stream.transform(passwordValidator);
  Function(String) get passwordAdd => _passwordCtrl.add;
  String get passwordValue => _passwordCtrl.value;

  close() {
    _passwordCtrl.close();
  }
}
