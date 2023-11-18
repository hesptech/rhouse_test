// To parse this JSON data, do
//
//     final codeRequestModel = codeRequestModelFromJson(jsonString);

import 'dart:convert';

CodeRequestModel codeRequestModelFromJson(String str) => CodeRequestModel.fromJson(json.decode(str));

String codeRequestModelToJson(CodeRequestModel data) => json.encode(data.toJson());

class CodeRequestModel {
    String email;
    int otp;

    CodeRequestModel({
        required this.email,
        required this.otp,
    });

    factory CodeRequestModel.fromJson(Map<String, dynamic> json) => CodeRequestModel(
        email: json["email"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
    };
}
