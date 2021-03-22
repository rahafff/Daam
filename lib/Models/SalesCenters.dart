// To parse this JSON data, do
//
//     final salesCentersModel = salesCentersModelFromJson(jsonString);

import 'dart:convert';

SalesCentersModel salesCentersModelFromJson(String str) => SalesCentersModel.fromJson(json.decode(str));

String salesCentersModelToJson(SalesCentersModel data) => json.encode(data.toJson());

class SalesCentersModel {
  SalesCentersModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<SalesCenter> data;
  int code;

  factory SalesCentersModel.fromJson(Map<String, dynamic> json) => SalesCentersModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SalesCenter>.from(json["data"].map((x) => SalesCenter.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}

class SalesCenter {
  SalesCenter({
    this.id,
    this.cityId,
    this.name,
    this.phoneNumber,
    this.email,
    this.location,
    this.longitude,
    this.latitude,
    this.city,
  });

  int id;
  int cityId;
  String name;
  String phoneNumber;
  String email;
  String location;
  String longitude;
  String latitude;
  City city;

  factory SalesCenter.fromJson(Map<String, dynamic> json) => SalesCenter(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    name: json["name"] == null ? null : json["name"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    email: json["email"] == null ? null : json["email"],
    location: json["location"] == null ? null : json["location"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "city_id": cityId == null ? null : cityId,
    "name": name == null ? null : name,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "email": email == null ? null : email,
    "location": location == null ? null : location,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "city": city == null ? null : city.toJson(),
  };
}

class City {
  City({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
