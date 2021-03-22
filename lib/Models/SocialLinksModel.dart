// To parse this JSON data, do
//
//     final socialLinksModel = socialLinksModelFromJson(jsonString);

import 'dart:convert';

SocialLinksModel socialLinksModelFromJson(String str) => SocialLinksModel.fromJson(json.decode(str));

String socialLinksModelToJson(SocialLinksModel data) => json.encode(data.toJson());

class SocialLinksModel {
  SocialLinksModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) => SocialLinksModel(
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
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedIn,
    this.youtube,
    this.phone,
    this.email,
    this.description,
  });

  String facebook;
  String instagram;
  String twitter;
  String linkedIn;
  String youtube;
  String phone;
  String email;
  String description;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    facebook: json["facebook"] == null ? null : json["facebook"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    linkedIn: json["linkedIn"] == null ? null : json["linkedIn"],
    youtube: json["youtube"] == null ? null : json["youtube"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook == null ? null : facebook,
    "instagram": instagram == null ? null : instagram,
    "twitter": twitter == null ? null : twitter,
    "linkedIn": linkedIn == null ? null : linkedIn,
    "youtube": youtube == null ? null : youtube,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "description": description == null ? null : description,
  };
}
