import 'dart:convert';

AuthenticationRequestModel authenticationRequestModelFromJson(String str) => AuthenticationRequestModel.fromJson(json.decode(str));

String authenticationRequestModelToJson(AuthenticationRequestModel data) => json.encode(data.toJson());

class AuthenticationRequestModel {
    String email;
    String password;

    AuthenticationRequestModel({
        required this.email,
        required this.password,
    });

    factory AuthenticationRequestModel.fromJson(Map<String, dynamic> json) => AuthenticationRequestModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
