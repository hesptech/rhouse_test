import 'dart:convert';

CreateUserResponseModel createUserResponseModelFromJson(String str) => CreateUserResponseModel.fromJson(json.decode(str));

String createUserResponseModelToJson(CreateUserResponseModel data) => json.encode(data.toJson());

class CreateUserResponseModel {
    int? userId;
    String? email;
    String? fullName;

    CreateUserResponseModel({
        this.userId,
        this.email,
        this.fullName,
    });

    factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) => CreateUserResponseModel(
        userId: json["userId"],
        email: json["email"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "fullName": fullName,
    };
}
