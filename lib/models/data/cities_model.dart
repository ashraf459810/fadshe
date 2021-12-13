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
  });

  int id;
  dynamic title;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        // title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
