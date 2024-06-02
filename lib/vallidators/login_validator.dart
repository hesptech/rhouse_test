import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class LoginValidator extends ValidatorMain {
  final _emailCtrl = BehaviorSubject<String>();
  final _passwordCtrl = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailCtrl.stream.transform(emailValidator);
  Function(String) get emailAdd => _emailCtrl.sink.add;
  String get emailValue => _emailCtrl.value;

  Stream<String> get passwordStream => _passwordCtrl.stream.transform(passwordValidator);
  Function(String) get passwordAdd => _passwordCtrl.sink.add;
  String get passwordValue => _passwordCtrl.value;

  Stream<bool> get submit => Rx.combineLatest2(emailStream, passwordStream, ((a, b) => true));

  close() {
    _emailCtrl.close();
    _passwordCtrl.close();
  }
}
