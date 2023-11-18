import 'dart:convert';

AuthInfoApp authInfoAppFromJson(String str) => AuthInfoApp.fromJson(json.decode(str));

String authInfoAppToJson(AuthInfoApp data) => json.encode(data.toJson());

class AuthInfoApp {
    int userId;
    String token;
    String tokenType;
    DateTime? expiresIn;
    String email;
    String fullName;
    String registrationDate;

    AuthInfoApp({
        this.userId = 0,
        this.token = "",
        this.tokenType = "",
        this.expiresIn,
        this.email = "",
        this.fullName = "",
        this.registrationDate = "",
    });

    factory AuthInfoApp.fromJson(Map<String, dynamic> json) => AuthInfoApp(
        userId: json["userId"],
        token: json["token"],
        tokenType: json["tokenType"],
        expiresIn: json["expiresIn"] == null ? null : DateTime.parse(json["expiresIn"]),
        email: json["email"],
        fullName: json["fullName"],
        registrationDate: json["registrationDate"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "token": token,
        "tokenType": tokenType,
        "expiresIn": expiresIn?.toIso8601String(),
        "email": email,
        "fullName": fullName,
        "registrationDate": registrationDate,
    };
}
