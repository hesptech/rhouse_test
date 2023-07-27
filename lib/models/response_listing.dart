import 'dart:convert';

class ResponseListing {
    List<History> history;

    ResponseListing({
        required this.history,
    });

    factory ResponseListing.fromJson(String str) => ResponseListing.fromMap(json.decode(str));

    factory ResponseListing.fromMap(Map<String, dynamic> json) => ResponseListing(
        history: List<History>.from(json["history"].map((x) => History.fromMap(x))),
    );
}


class History {

    DateTime? soldDate;
    Map<String, DateTime?> timestamps;
    String soldPrice;
    String listPrice;
    String lastStatus;

    History({
        required this.soldDate,
        required this.timestamps,
        required this.soldPrice,
        required this.listPrice,
        required this.lastStatus,
    });

    factory History.fromJson(String str) => History.fromMap(json.decode(str));

    factory History.fromMap(Map<String, dynamic> json) => History(
        soldDate: json["soldDate"] != null ? DateTime.parse(json["soldDate"]) : DateTime.parse("2000-01-01T21:55:44.000Z"),
        timestamps: Map.from(json["timestamps"]).map((k, v) => MapEntry<String, DateTime?>(k, v == null ? null : DateTime.parse(v))),
        soldPrice: json["soldPrice"] ?? '',
        listPrice: json["listPrice"] ?? '',
        lastStatus: json["lastStatus"] ?? '',
    );
}
