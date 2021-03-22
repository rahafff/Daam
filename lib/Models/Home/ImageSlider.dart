// To parse this JSON data, do
//
//     final imageSliderModel = imageSliderModelFromJson(jsonString);

import 'dart:convert';

ImageSliderModel imageSliderModelFromJson(String str) => ImageSliderModel.fromJson(json.decode(str));

String imageSliderModelToJson(ImageSliderModel data) => json.encode(data.toJson());

class ImageSliderModel {
  ImageSliderModel({
    this.message,
    this.data,
    this.code,
    this.link
  });

  String message;
  List<Datum> data;
  int code;
  String link;

  factory ImageSliderModel.fromJson(Map<String, dynamic> json) => ImageSliderModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
    link: json["link"] == null ? null : json["link"]
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
    this.photo,
  });

  int id;
  String photo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    photo: json["photo"] == null ? null : json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "photo": photo == null ? null : photo,
  };
}
