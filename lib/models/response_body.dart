import 'dart:convert';
import 'package:flutter_black_white/models/response_listings.dart';

class ResponseBody {
    ResponseBody({
        required this.page,
        required this.numPages,
        required this.pageSize,
        required this.count,
        required this.statistics,
        required this.listings,
    });

    int page;
    int numPages;
    int pageSize;
    int count;
    Statistics statistics;
    List<Listing> listings;

    factory ResponseBody.fromJson(String str) => ResponseBody.fromMap(json.decode(str));

    factory ResponseBody.fromMap(Map<String, dynamic> json) => ResponseBody(
        page: json["page"],
        numPages: json["numPages"],
        pageSize: json["pageSize"],
        count: json["count"],
        statistics: Statistics.fromMap(json["statistics"]),
        listings: List<Listing>.from(json["listings"].map((x) => Listing.fromMap(x))),
    );
}


class Statistics {
    Statistics({
        this.listPrice,
    });

    ListPrice? listPrice;

    factory Statistics.fromJson(String str) => Statistics.fromMap(json.decode(str));

    factory Statistics.fromMap(Map<String, dynamic> json) => Statistics(
        listPrice: ListPrice.fromMap(json["listPrice"]),
    );
}


class ListPrice {
    ListPrice({
        this.min,
        this.max,
    });

    int? min;
    int? max;

    factory ListPrice.fromJson(String str) => ListPrice.fromMap(json.decode(str));

    factory ListPrice.fromMap(Map<String, dynamic> json) => ListPrice(
        min: json["min"].toInt(),
        max: json["max"].toInt(),
    );
}