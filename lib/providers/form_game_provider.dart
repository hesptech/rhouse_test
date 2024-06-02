import 'package:flutter/material.dart';

class FormGameProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String price = '';

  validatedForm(){
    formKey.currentState!.validate();
  }
}