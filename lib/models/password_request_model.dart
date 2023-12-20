
import 'dart:convert';

PasswordRequestModel passwordRequestModelFromJson(String str) => PasswordRequestModel.fromJson(json.decode(str));

String passwordRequestModelToJson(PasswordRequestModel data) => json.encode(data.toJson());

class PasswordRequestModel {
    String email;
    String passwordNew;

    PasswordRequestModel({
       required this.email,
       required this.passwordNew,
    });

    factory PasswordRequestModel.fromJson(Map<String, dynamic> json) => PasswordRequestModel(
        email: json["email"] ?? "",
        passwordNew: json["passwordNew"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "passwordNew": passwordNew,
    };
}
