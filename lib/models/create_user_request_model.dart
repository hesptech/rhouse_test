import 'dart:convert';

CreateUserRequestModel createUserRequestModelFromJson(String str) => CreateUserRequestModel.fromJson(json.decode(str));

String createUserRequestModelToJson(CreateUserRequestModel data) => json.encode(data.toJson());

class CreateUserRequestModel {
    String fullName;
    String email;
    String password;

    CreateUserRequestModel({
        required this.fullName,
        required this.email,
        required this.password,
    });

    factory CreateUserRequestModel.fromJson(Map<String, dynamic> json) => CreateUserRequestModel(
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
    };
}
