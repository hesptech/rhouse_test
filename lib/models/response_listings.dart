import 'dart:convert';

class Listing {
  Listing({
    this.listingClass,
    this.listDate,
    this.images,
    this.daysOnMarket,
    this.listPrice,
    this.address,
    this.details,
    this.rooms,
    this.lot,
    this.mlsNumber,
  });

  String? listingClass;
  DateTime? listDate;
  List<String>? images;
  String? daysOnMarket;
  String? listPrice;
  Address? address;
  Details? details;
  Map<String, Room>? rooms;
  Lot? lot;
  String? mlsNumber;

  factory Listing.fromJson(String str) => Listing.fromMap(json.decode(str));

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
    listingClass: json["class"],
    listDate: DateTime.parse(json["listDate"]),
    images: List<String>.from(json["images"].map((x) => x)),
    daysOnMarket: json["daysOnMarket"],
    listPrice: json["listPrice"],
    address: Address.fromMap(json["address"]),
    details: Details.fromMap(json["details"]),
    rooms: Map.from(json["rooms"]).map((k, v) => MapEntry<String, Room>(k, Room.fromMap(v))),
    lot: Lot.fromMap(json["lot"]),
    mlsNumber: json["mlsNumber"],
  );
}


class Room {
    Room({
        this.features,
        this.level,
        this.length,
        this.width,
        this.description,
        this.features3,
        this.features2,
    });

    String? features;
    //Level level;
    String? level;
    String? length;
    String? width;
    String? description;
    String? features3;
    String? features2;

    factory Room.fromJson(String str) => Room.fromMap(json.decode(str));

    factory Room.fromMap(Map<String, dynamic> json) => Room(
        features: json["features"] ?? json["features"],
        //level: json["level"] ?? levelValues.map[json["level"]],
        level: json["level"],
        length: json["length"] ?? json["length"],
        width: json["width"] ?? json["width"],
        description: json["description"],
        features3: json["features3"] ?? json["features3"],
        features2: json["features2"] ?? json["features2"],
    );
}


class Address {
  Address({
    this.unitNumber,
    this.streetNumber,
    this.streetName,
    this.streetSuffix,
    this.streetDirection,
    this.neighborhood,
    this.city,
    this.area,
  });

  String? unitNumber;
  String? streetName;
  String? streetNumber;
  String? streetSuffix;
  String? streetDirection;
  String? neighborhood;
  String? city;
  String? area;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    unitNumber: json["unitNumber"],
    streetNumber: json["streetNumber"],
    streetName: json["streetName"],
    streetSuffix: json["streetSuffix"],
    streetDirection: json["streetDirection"],
    neighborhood: json["neighborhood"],
    city: json["city"],
    area: json["area"],
  );
}


class Details {
  Details({
    this.propertyType,
    this.numRooms,
    this.numBedroomsPlus,
    this.numBathrooms,
    this.numParkingSpaces,
    this.sqft,
  });

  String? propertyType;
  String? numRooms;
  String? numBedroomsPlus;
  String? numBathrooms;
  String? numParkingSpaces;
  String? sqft;

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    propertyType: json["propertyType"],
    numRooms: json["numRooms"],
    numBedroomsPlus: json["numBedroomsPlus"],
    numBathrooms: json["numBathrooms"],
    numParkingSpaces: json["numParkingSpaces"],
    sqft: json["sqft"],
  );
}


class Lot {
  Lot({
    this.depth,
    this.width,
  });

  String? depth;
  String? width;

  factory Lot.fromJson(String str) => Lot.fromMap(json.decode(str));

  factory Lot.fromMap(Map<String, dynamic> json) => Lot(
    depth: json["depth"],
    width: json["width"],
  );
}