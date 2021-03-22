// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    this.id,
    this.cityId,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.serialNumber,
    this.apiToken,
    this.createdAt,
    this.updatedAt,
    this.businessName,
    this.businessTypeId,
    this.description,
    this.latitude,
    this.location,
    this.longitude,
    this.networkId,
    this.photo,
    this.rate,
    this.isProvider,
    this.businessNameEn
  });

  int id;
  int cityId;
  String name;
  String email;
  String phoneNumber;
  int gender;
  String serialNumber;
  String apiToken;
  DateTime createdAt;
  DateTime updatedAt;

  bool isProvider;

  int networkId;
  int businessTypeId;
  String businessName;
  String businessNameEn;
  String location;
  String longitude;
  String latitude;
  String description;
  String photo;
  String rate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    gender: json["gender"] == null ? null : json["gender"],
    serialNumber: json["serial_number"] == null ? null : json["serial_number"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isProvider: json["is_provider"] == null ? null : json["is_provider"] == "1",

    networkId: json["network_id"] == null ? null : json["network_id"],
    businessTypeId: json["business_type_id"] == null ? null : json["business_type_id"],
    businessName: json["business_name"] == null ? null : json["business_name"],
    businessNameEn: json["business_name_en"] == null ? null : json["business_name_en"],
    location: json["location"] == null ? null : json["location"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    description: json["description"] == null ? null : json["description"],
    photo: json["photo"] == null ? null : json["photo"],
    rate: json["rate"] == null ? null : json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "city_id": cityId == null ? null : cityId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "gender": gender == null ? null : gender,
    "serial_number": serialNumber == null ? null : serialNumber,
    "api_token": apiToken == null ? null : apiToken,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "is_provider": isProvider == null? null : isProvider?"1":"2",
    "network_id":networkId == null? null : networkId,
    "business_type_id":businessTypeId == null ? null : businessTypeId,
    "business_name":businessName == null ? null : businessName,
    "location":location == null ? null : location,
    "photo":photo == null ? null : photo
  };
}
