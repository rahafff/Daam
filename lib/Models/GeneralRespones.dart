// To parse this JSON data, do
//
//     final generalModel = generalModelFromJson(jsonString);

import 'dart:convert';

GeneralModel generalModelFromJson(String str) => GeneralModel.fromJson(json.decode(str));

String generalModelToJson(GeneralModel data) => json.encode(data.toJson());

class GeneralModel {
  GeneralModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  dynamic data;
  int code;

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"],
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data,
    "code": code == null ? null : code,
  };
}
