import 'dart:async';

class ValidatorMain {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError("Email address is required");
      return;
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!emailRegex.hasMatch(value)) {
      sink.addError("The email address is not valid");
      return;
    }

    sink.add(value);
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    final passwordRegex = RegExp(r'^(?=.{8,16}$)[A-Za-z0-9\$\&\-\#_]+$');

    if (!passwordRegex.hasMatch(value)) {
      sink.addError("Password is not valid");
      return;
    }

    sink.add(value);
  });

  final nameFullValidator = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError("Completed name is required");
      return;
    }

    final nameFullRegex = RegExp(r'^[a-zA-Z ]{2,30}$');

    if (!nameFullRegex.hasMatch(value)) {
      sink.addError("Name has incorrect characters");
      return;
    }

    sink.add(value);
  });

  final pinValidator = StreamTransformer<String, String>.fromHandlers(handleData: ((value, sink) {
    if (value.isEmpty) {
      sink.addError("Enter a valid value");
      return;
    }

    final numberRegex = RegExp(r'^[0-9]+$');

    if (!numberRegex.hasMatch(value)) {
      sink.addError("Enter a valid value");
      return;
    }

    sink.add(value);
  }));
}
