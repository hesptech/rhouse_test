import 'package:flutter_black_white/models/authentication_response_model.dart';
import 'package:flutter_black_white/models/create_user_response_model.dart';

class BaseResponseModel<T> {
  String message;
  String error;
  T? data;

  BaseResponseModel({this.message = "", this.data, this.error = ""});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) => BaseResponseModel(
        message: json["message"] ?? "",
        data: json["data"] != null ? _getDataGeneric(T, json["data"]) : null,
        error: json["error"] ?? "",
      );
}

_getDataGeneric<T>(T key, Map<String, dynamic> jsonData) {
  if (identical(key, AuthenticationResponseModel())) {
    return AuthenticationResponseModel.fromJson(jsonData);
  } else if (identical(key, CreateUserResponseModel)) {
    return CreateUserResponseModel.fromJson(jsonData);
  } else {
    return null;
  }
}
