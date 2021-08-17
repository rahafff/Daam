// To parse this JSON data, do
//
//     final nearestServiceProvidersModel = nearestServiceProvidersModelFromJson(jsonString);

import 'dart:convert';

NearestServiceProvidersModel nearestServiceProvidersModelFromJson(String str) => NearestServiceProvidersModel.fromJson(json.decode(str));

String nearestServiceProvidersModelToJson(NearestServiceProvidersModel data) => json.encode(data.toJson());

class NearestServiceProvidersModel {
  NearestServiceProvidersModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory NearestServiceProvidersModel.fromJson(Map<String, dynamic> json) => NearestServiceProvidersModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}

class Datum {
  Datum({
    this.id,
    this.businessName,
    this.latitude,
    this.longitude,
    this.networkId
  });

  int id;
  String businessName;
  String latitude;
  String longitude;
  int networkId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    businessName: json["business_name"] == null ? null : json["business_name"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    networkId: json["network_id"] == null ? null : json["network_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "business_name": businessName == null ? null : businessName,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}
