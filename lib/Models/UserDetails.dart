// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
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
    this.deviceType,
    this.status,
    this.city,
  });

  int id;
  int cityId;
  String name;
  String email;
  String phoneNumber;
  int gender;
  String serialNumber;
  int deviceType;
  int status;
  City city;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    gender: json["gender"] == null ? null : json["gender"],
    serialNumber: json["serial_number"] == null ? null : json["serial_number"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    status: json["status"] == null ? null : json["status"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "city_id": cityId == null ? null : cityId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "gender": gender == null ? null : gender,
    "serial_number": serialNumber == null ? null : serialNumber,
    "device_type": deviceType == null ? null : deviceType,
    "status": status == null ? null : status,
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
