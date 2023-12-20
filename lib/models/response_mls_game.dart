import 'dart:convert';

class ResponseMlsGame {
    ResponseMlsGame({
        required this.mlsGame,
    });

    List<String> mlsGame;

    factory ResponseMlsGame.fromRawJson(String str) => ResponseMlsGame.fromJson(json.decode(str));

    factory ResponseMlsGame.fromJson(Map<String, dynamic> json) => ResponseMlsGame(
        mlsGame: List<String>.from(json["mlsGame"].map((x) => x ?? '')),
    );
}
