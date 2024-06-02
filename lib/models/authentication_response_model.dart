import 'dart:convert';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) => AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) => json.encode(data.toJson());

class AuthenticationResponseModel {
    int userId;
    String token;
    String tokenType;
    DateTime? expiresIn;
    String email;
    String name;
    String lastName;
    DateTime? registrationDate;

    AuthenticationResponseModel({
        this.userId = 0,
        this.token = "",
        this.tokenType = "",
        this.expiresIn,
        this.email = "",
        this.name = "",
        this.lastName = "",
        this.registrationDate,
    });

    factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) => AuthenticationResponseModel(
        userId: json["userId"] ?? 0,
        token: json["token"] ?? "",
        tokenType: json["tokenType"] ?? "",
        expiresIn: json["expiresIn"] == null ? null : DateTime.parse(json["expiresIn"]),
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        lastName: json["lastName"] ?? "",
        registrationDate: json["registrationDate"] == null ? null : DateTime.parse(json["registrationDate"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "token": token,
        "tokenType": tokenType,
        "expiresIn": expiresIn?.toIso8601String(),
        "email": email,
        "name": name,
        "lastName": lastName,
        "registrationDate": registrationDate?.toIso8601String(),
    };
}
