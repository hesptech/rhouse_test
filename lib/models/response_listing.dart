import 'dart:convert';
import 'package:flutter_black_white/models/response_listings.dart';

class ResponseListing {
    List<History>? history;
    String? mlsNumber;
    String? listingClass;
    List<String>? images;
    DateTime? listDate;
    Timestamps? timestamps;
    String? daysOnMarket;
    String? listPrice;
    String? soldPrice;
    DateTime? soldDate;
    String? status;
    String? lastStatus;
    Address? address;
    Details? details;
    Lot? lot;
    String? occupancy;

    ResponseListing({
      this.history,
      this.mlsNumber,
      this.listingClass,
      this.images,
      this.listDate,
      this.timestamps,
      this.daysOnMarket,
      this.listPrice,
      this.soldPrice,
      this.soldDate,
      this.status,
      this.lastStatus,
      this.address,
      this.details,
      this.lot,
      this.occupancy,
    });

    factory ResponseListing.fromJson(String str) => ResponseListing.fromMap(json.decode(str));

    factory ResponseListing.fromMap(Map<String, dynamic> json) => ResponseListing(
      history: List<History>.from(json["history"].map((x) => History.fromMap(x))),
      mlsNumber: json["mlsNumber"],
      listingClass: json["class"],
      images: List<String>.from(json["images"].map((x) => x)),
      listDate: DateTime.parse(json["listDate"]),
      timestamps: Timestamps.fromMap(json["timestamps"]),
      daysOnMarket: json["daysOnMarket"],
      listPrice: json["listPrice"],
      soldPrice: json["soldPrice"],
      soldDate: json["soldDate"] != null ? DateTime.parse(json["soldDate"]) : DateTime.parse("2023-01-01T21:55:44.000Z"),
      status: json["status"],
      lastStatus: json["lastStatus"],
      address: Address.fromMap(json["address"]),
      details: Details.fromMap(json["details"]),
      lot: Lot.fromMap(json["lot"]),
      occupancy: json["occupancy"],
    );
}


class History {
    String mlsNumber;
    DateTime? soldDate;
    Map<String, DateTime?> timestamps;
    String soldPrice;
    String listPrice;
    String lastStatus;

    History({
        required this.mlsNumber,
        required this.soldDate,
        required this.timestamps,
        required this.soldPrice,
        required this.listPrice,
        required this.lastStatus,
    });

    factory History.fromJson(String str) => History.fromMap(json.decode(str));

    factory History.fromMap(Map<String, dynamic> json) => History(
        mlsNumber: json["mlsNumber"],
        soldDate: json["soldDate"] != null ? DateTime.parse(json["soldDate"]) : DateTime.parse("2000-01-01T21:55:44.000Z"),
        timestamps: Map.from(json["timestamps"]).map((k, v) => MapEntry<String, DateTime?>(k, v == null ? null : DateTime.parse(v))),
        soldPrice: json["soldPrice"],
        listPrice: json["listPrice"],
        lastStatus: json["lastStatus"],
    );
}
