// To parse this JSON data, do
//
//     final htmlBodyModel = htmlBodyModelFromJson(jsonString);

import 'dart:convert';

HtmlBodyModel htmlBodyModelFromJson(String str) => HtmlBodyModel.fromJson(json.decode(str));

String htmlBodyModelToJson(HtmlBodyModel data) => json.encode(data.toJson());

class HtmlBodyModel {
  HtmlBodyModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory HtmlBodyModel.fromJson(Map<String, dynamic> json) => HtmlBodyModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
    "code": code == null ? null : code,
  };
}

class Data {
  Data({
    this.body,
  });

  String body;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    body: json["body"] == null ? null : json["body"],
  );

  Map<String, dynamic> toJson() => {
    "body": body == null ? null : body,
  };
}
