// To parse this JSON data, do
//
//     final serialNumbers = serialNumbersFromJson(jsonString);

import 'dart:convert';

SerialNumbersModel serialNumbersFromJson(String str) => SerialNumbersModel.fromJson(json.decode(str));

String serialNumbersToJson(SerialNumbersModel data) => json.encode(data.toJson());

class SerialNumbersModel {
  SerialNumbersModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<SerialNumber> data;
  int code;

  factory SerialNumbersModel.fromJson(Map<String, dynamic> json) => SerialNumbersModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null || json["data"] == ""? null : List<SerialNumber>.from(json["data"].map((x) => SerialNumber.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}

class SerialNumber {
  SerialNumber({
    this.id,
    this.cardId,
    this.serialNumber,
  });

  int id;
  int cardId;
  String serialNumber;

  factory SerialNumber.fromJson(Map<String, dynamic> json) => SerialNumber(
    id: json["id"] == null ? null : json["id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    serialNumber: json["serial_number"] == null ? null : json["serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "card_id": cardId == null ? null : cardId,
    "serial_number": serialNumber == null ? null : serialNumber,
  };
}
