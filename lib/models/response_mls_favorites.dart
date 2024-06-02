import 'dart:convert';

class ResponseMlsFavorites {
    ResponseMlsFavorites({
        required this.mlsFavorites,
    });

    List<String> mlsFavorites;

    factory ResponseMlsFavorites.fromRawJson(String str) => ResponseMlsFavorites.fromJson(json.decode(str));

    factory ResponseMlsFavorites.fromJson(Map<String, dynamic> json) => ResponseMlsFavorites(
        mlsFavorites: List<String>.from(json["mlsFavorites"].map((x) => x ?? '')),
    );
}