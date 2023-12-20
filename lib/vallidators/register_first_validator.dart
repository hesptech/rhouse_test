import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class RegisterFirstValidator extends ValidatorMain {
  final _fullNameCtrl = BehaviorSubject<String>();
  final _emailCtrl = BehaviorSubject<String>();
  final _passwordCtrl = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailCtrl.stream.transform(emailValidator);
  Function(String) get emailAdd => _emailCtrl.sink.add;
  String get emailValue => _emailCtrl.value;

  Stream<String> get fullNameStream => _fullNameCtrl.stream.transform(nameFullValidator);
  Function(String) get fullNameAdd => _fullNameCtrl.sink.add;
  String get fullNameValue => _fullNameCtrl.value;

  Stream<String> get passwordStream => _passwordCtrl.stream.transform(passwordValidator);
  Function(String) get passwordAdd => _passwordCtrl.sink.add;
  String get passwordValue => _passwordCtrl.value;

  Stream<bool> get submit => Rx.combineLatest3(fullNameStream, emailStream, passwordStream, ((a,b,c) => true));

  close() {
    _fullNameCtrl.close();
    _emailCtrl.close();
    _passwordCtrl.close();
  }
}
