// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.azsvr,
    this.cities,
  });

  String azsvr;
  List<City> cities;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        azsvr: json["AZSVR"],
        cities: List<City>.from(json["Cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AZSVR": azsvr,
        "Cities": List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.title,
    this.countryIsoCode,
    this.parentId,
    this.internalDeliveryPrice,
    this.internalDeliveryDays,
    this.externalDeliveryPrice,
    this.externalDeliveryDays,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String title;
  dynamic countryIsoCode;
  dynamic parentId;
  dynamic internalDeliveryPrice;
  dynamic internalDeliveryDays;
  dynamic externalDeliveryPrice;
  dynamic externalDeliveryDays;
  dynamic createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        title: json["title"],
        countryIsoCode: json["country_iso_code"],
        parentId: json["parent_id"],
        internalDeliveryPrice: json["internal_delivery_price"].toDouble(),
        internalDeliveryDays: json["internal_delivery_days"],
        externalDeliveryPrice: json["external_delivery_price"],
        externalDeliveryDays: json["external_delivery_days"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "country_iso_code": countryIsoCode,
        "parent_id": parentId,
        "internal_delivery_price": internalDeliveryPrice,
        "internal_delivery_days": internalDeliveryDays,
        "external_delivery_price": externalDeliveryPrice,
        "external_delivery_days": externalDeliveryDays,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
