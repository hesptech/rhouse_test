import 'package:flutter_black_white/vallidators/validator_main.dart';
import 'package:rxdart/rxdart.dart';

class RegisterPinValidator extends ValidatorMain {
  final _pin1 = BehaviorSubject<String>();
  final _pin2 = BehaviorSubject<String>();
  final _pin3 = BehaviorSubject<String>();
  final _pin4 = BehaviorSubject<String>();

  Stream<String> get pin1Stream => _pin1.stream.transform(pinValidator);
  Function(String) get pin1Add => _pin1.sink.add;
  String get pin1Value => _pin1.value;

  Stream<String> get pin2Stream => _pin2.stream.transform(pinValidator);
  Function(String) get pin2Add => _pin2.sink.add;
  String get pin2Value => _pin2.value;

  Stream<String> get pin3Stream => _pin3.stream.transform(pinValidator);
  Function(String) get pin3Add => _pin3.sink.add;
  String get pin3Value => _pin3.value;

  Stream<String> get pin4Stream => _pin4.stream.transform(pinValidator);
  Function(String) get pin4Add => _pin4.sink.add;
  String get pin4Value => _pin4.value;

  Stream<bool> get submit => Rx.combineLatest4(pin1Stream, pin2Stream, pin3Stream, pin4Stream, (a, b, c, d) => true);
}
