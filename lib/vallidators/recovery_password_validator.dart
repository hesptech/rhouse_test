import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class RecoveryPasswordValidator extends ValidatorMain {
  final _emailCtrl = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailCtrl.stream.transform(emailValidator);
  Function(String) get emailAdd => _emailCtrl.sink.add;
  String get emailValue => _emailCtrl.value;

  close() {
    _emailCtrl.close();
  }
}
