import 'dart:convert';

class ResponseMlsGuesses {
    ResponseMlsGuesses({
        required this.mlsGuesses,
    });

    List<String> mlsGuesses;

    factory ResponseMlsGuesses.fromRawJson(String str) => ResponseMlsGuesses.fromJson(json.decode(str));

    factory ResponseMlsGuesses.fromJson(Map<String, dynamic> json) => ResponseMlsGuesses(
        mlsGuesses: List<String>.from(json["mlsGuesses"].map((x) => x)),
    );
}
