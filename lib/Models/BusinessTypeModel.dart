// To parse this JSON data, do
//
//     final bussinessTypeModel = bussinessTypeModelFromJson(jsonString);

import 'dart:convert';

BusinessTypeModel bussinessTypeModelFromJson(String str) => BusinessTypeModel.fromJson(json.decode(str));

String bussinessTypeModelToJson(BusinessTypeModel data) => json.encode(data.toJson());

class BusinessTypeModel {
  BusinessTypeModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<Datum> data;
  int code;

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) => BusinessTypeModel(
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
    this.networkId,
    this.name,
    this.network,
  });

  int id;
  int networkId;
  String name;
  Network network;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    name: json["name"] == null ? null : json["name"],
    network: json["network"] == null ? null : Network.fromJson(json["network"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "network_id": networkId == null ? null : networkId,
    "name": name == null ? null : name,
    "network": network == null ? null : network.toJson(),
  };
}

class Network {
  Network({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
