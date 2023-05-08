import 'dart:convert';

class Listing {
  Listing({
    this.mlsNumber,
    this.listingClass,
    this.images,
    this.listDate,
    this.timestamps,
    this.daysOnMarket,
    this.listPrice,
    this.address,
    this.details,
    this.rooms,
    this.lot,
    this.taxes,
    this.occupancy,
    this.nearby,
    this.condominium,
    this.office,
    this.map,
  });

  String? mlsNumber;
  String? listingClass;
  List<String>? images;
  DateTime? listDate;
  Timestamps? timestamps;
  String? daysOnMarket;
  String? listPrice;
  Address? address;
  Details? details;
  Map<String, Room>? rooms;
  Lot? lot;
  Taxes? taxes;
  String? occupancy;
  Nearby? nearby;
  Condominium? condominium;
  Office? office;
  MapClass? map;

  factory Listing.fromJson(String str) => Listing.fromMap(json.decode(str));

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
    mlsNumber: json["mlsNumber"],
    listingClass: json["class"],
    images: List<String>.from(json["images"].map((x) => x)),
    listDate: DateTime.parse(json["listDate"]),
    timestamps: Timestamps.fromMap(json["timestamps"]),
    daysOnMarket: json["daysOnMarket"],
    listPrice: json["listPrice"],
    address: Address.fromMap(json["address"]),
    details: Details.fromMap(json["details"]),
    rooms: Map.from(json["rooms"]).map((k, v) => MapEntry<String, Room>(k, Room.fromMap(v))),
    lot: Lot.fromMap(json["lot"]),
    taxes: Taxes.fromMap(json["taxes"]),
    occupancy: json["occupancy"],
    nearby: Nearby.fromMap(json["nearby"]),
    condominium: Condominium.fromMap(json["condominium"]),
    office: Office.fromMap(json["office"]),
    map: MapClass.fromMap(json["map"]),
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


class Timestamps {
  Timestamps({
    this.listingEntryDate
  });

  DateTime? listingEntryDate;

  factory Timestamps.fronJson(String str) => Timestamps.fromMap(json.decode(str));

  factory Timestamps.fromMap(Map<String, dynamic> json) => Timestamps(
    listingEntryDate: json["listingEntryDate"] != null ? DateTime.parse(json["listingEntryDate"]) : DateTime.parse("2023-02-21T21:55:44.000Z"),
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
    this.majorIntersection,
  });

  String? unitNumber;
  String? streetName;
  String? streetNumber;
  String? streetSuffix;
  String? streetDirection;
  String? neighborhood;
  String? city;
  String? area;
  String? majorIntersection;

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
    majorIntersection: json['majorIntersection'],
  );
}


class Details {
  Details({
    this.propertyType,
    this.numBedrooms,
    this.numBedroomsPlus,
    this.numBathrooms,
    this.numParkingSpaces,
    this.sqft,
    this.description,
    this.style,
    this.exteriorConstruction1,
    this.garage,
    this.numGarageSpaces,
    this.swimmingPool,
    this.waterSource,
    this.handicappedEquipped,
    this.yearBuilt,
    this.heating,
    this.airConditioning,
    this.numKitchens,
    this.basement1,
    this.numFireplaces,
    this.laundryLevel,
    this.elevator,
    this.balcony,
    this.ensuiteLaundry,
    this.centralVac,
    this.locker,
  });

  String? propertyType;
  String? numBedrooms;
  String? numBedroomsPlus;
  String? numBathrooms;
  String? numParkingSpaces;
  String? sqft;
  String? description;
  String? style;
  String? exteriorConstruction1;
  String? garage;
  String? numGarageSpaces;
  String? swimmingPool;
  String? waterSource;
  String? handicappedEquipped;
  String? yearBuilt;
  String? heating;
  String? airConditioning;
  String? numKitchens;
  String? basement1;
  String? numFireplaces;
  String? laundryLevel;
  String? elevator;
  String? balcony;
  String? ensuiteLaundry;
  String? centralVac;
  String? locker;

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    propertyType: json["propertyType"],
    numBedrooms: json["numBedrooms"],
    numBedroomsPlus: json["numBedroomsPlus"],
    numBathrooms: json["numBathrooms"],
    numParkingSpaces: json["numParkingSpaces"],
    sqft: json["sqft"],
    description: json["description"],
    style: json["style"],
    exteriorConstruction1: json["exteriorConstruction1"],
    garage: json["garage"],
    numGarageSpaces: json["numGarageSpaces"],
    swimmingPool: json["swimmingPool"],
    waterSource: json["waterSource"],
    handicappedEquipped: json["handicappedEquipped"],
    yearBuilt: json["yearBuilt"],
    heating: json["heating"],
    airConditioning: json["airConditioning"],
    numKitchens: json["numKitchens"],
    basement1: json["basement1"],
    numFireplaces: json["numFireplaces"],
    laundryLevel: json["laundryLevel"],
    elevator: json["elevator"],
    balcony: json["balcony"],
    ensuiteLaundry: json["ensuiteLaundry"],
    centralVac: json["centralVac"],
    locker: json["locker"],
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


class Taxes {
  Taxes({
    this.annualAmount,
    this.assessmentYear,
  });

  String? annualAmount;
  String? assessmentYear;

  factory Taxes.fromJson(String str) => Taxes.fromMap(json.decode(str));

  factory Taxes.fromMap(Map<String, dynamic> json) => Taxes(
    annualAmount: json["annualAmount"],
    assessmentYear: json["assessmentYear"],
  );
}


class Nearby {
    List<String> ammenities;

    Nearby({
        required this.ammenities,
    });

    factory Nearby.fromJson(String str) => Nearby.fromMap(json.decode(str));

    factory Nearby.fromMap(Map<String, dynamic> json) => Nearby(
        ammenities: List<String>.from(json["ammenities"].map((x) => x)),
    );
}


class Condominium {
    dynamic pets;
    dynamic condoCorpNum;
    dynamic parkingType;
    Fees fees;
    dynamic stories;
    dynamic propertyMgr;
    dynamic lockerLevel;
    dynamic unitNumber;
    dynamic buildingInsurance;
    dynamic locker;
    dynamic condoCorp;
    dynamic sharesPercentage;
    dynamic ensuiteLaundry;
    dynamic exposure;
    String lockerNumber;
    dynamic lockerUnitNumber;
    List<dynamic> ammenities;

    Condominium({
        this.pets,
        this.condoCorpNum,
        this.parkingType,
        required this.fees,
        this.stories,
        this.propertyMgr,
        this.lockerLevel,
        this.unitNumber,
        this.buildingInsurance,
        this.locker,
        this.condoCorp,
        this.sharesPercentage,
        this.ensuiteLaundry,
        this.exposure,
        required this.lockerNumber,
        this.lockerUnitNumber,
        required this.ammenities,
    });

    factory Condominium.fromJson(String str) => Condominium.fromMap(json.decode(str));

    factory Condominium.fromMap(Map<String, dynamic> json) => Condominium(
        pets: json["pets"],
        condoCorpNum: json["condoCorpNum"],
        parkingType: json["parkingType"],
        fees: Fees.fromMap(json["fees"]),
        stories: json["stories"],
        propertyMgr: json["propertyMgr"],
        lockerLevel: json["lockerLevel"],
        unitNumber: json["unitNumber"],
        buildingInsurance: json["buildingInsurance"],
        locker: json["locker"],
        condoCorp: json["condoCorp"],
        sharesPercentage: json["sharesPercentage"],
        ensuiteLaundry: json["ensuiteLaundry"],
        exposure: json["exposure"],
        lockerNumber: json["lockerNumber"],
        lockerUnitNumber: json["lockerUnitNumber"],
        ammenities: List<dynamic>.from(json["ammenities"].map((x) => x)),
    );
}


class Fees {
    String cableInlc;
    String waterIncl;
    String heatIncl;
    dynamic taxesIncl;
    String parkingIncl;
    dynamic maintenance;
    String hydroIncl;

    Fees({
        required this.cableInlc,
        required this.waterIncl,
        required this.heatIncl,
        this.taxesIncl,
        required this.parkingIncl,
        this.maintenance,
        required this.hydroIncl,
    });

    factory Fees.fromJson(String str) => Fees.fromMap(json.decode(str));

    factory Fees.fromMap(Map<String, dynamic> json) => Fees(
        cableInlc: json["cableInlc"],
        waterIncl: json["waterIncl"],
        heatIncl: json["heatIncl"],
        taxesIncl: json["taxesIncl"],
        parkingIncl: json["parkingIncl"],
        maintenance: json["maintenance"],
        hydroIncl: json["hydroIncl"],
    );
}


class Office {
  Office({
    this.brokerageName,
  });

  String? brokerageName;

  factory Office.fromJson(String str) => Office.fromMap(json.decode(str));

  factory Office.fromMap(Map<String, dynamic> json) => Office (
    brokerageName: json["brokerageName"]
  );
}


class MapClass {
    String latitude;
    String point;
    String longitude;

    MapClass({
        required this.latitude,
        required this.point,
        required this.longitude,
    });

    factory MapClass.fromJson(String str) => MapClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MapClass.fromMap(Map<String, dynamic> json) => MapClass(
        latitude: json["latitude"],
        point: json["point"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "point": point,
        "longitude": longitude,
    };
}

