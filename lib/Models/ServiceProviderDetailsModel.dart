// To parse this JSON data, do
//
//     final serviceProviderDetailsModel = serviceProviderDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceProviderDetailsModel serviceProviderDetailsModelFromJson(String str) => ServiceProviderDetailsModel.fromJson(json.decode(str));

String serviceProviderDetailsModelToJson(ServiceProviderDetailsModel data) => json.encode(data.toJson());

class ServiceProviderDetailsModel {
  ServiceProviderDetailsModel({
    this.message,
    this.data,
    this.code,
    this.link,
  });

  String message;
  Data data;
  int code;
  String link;

  factory ServiceProviderDetailsModel.fromJson(Map<String, dynamic> json) => ServiceProviderDetailsModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "code": code,
    "link": link,
  };
}

class Data {
  Data({
    this.id,
    this.cityId,
    this.networkId,
    this.businessTypeId,
    this.name,
    this.businessName,
    this.email,
    this.phoneNumber,
    this.location,
    this.longitude,
    this.latitude,
    this.description,
    this.photo,
    this.rate,
    this.facebook,
    this.instagram,
    this.youtube,
    this.linkedIn,
    this.telegram,
    this.canRate,
    this.city,
    this.network,
    this.businessType,
  });

  int id;
  int cityId;
  int networkId;
  int businessTypeId;
  String name;
  String businessName;
  String email;
  String phoneNumber;
  String location;
  String longitude;
  String latitude;
  String description;
  String photo;
  double rate;
  String facebook;
  String instagram;
  String youtube;
  String linkedIn;
  String telegram;
  int canRate;
  BusinessType city;
  BusinessType network;
  BusinessType businessType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    cityId: json["city_id"],
    networkId: json["network_id"],
    businessTypeId: json["business_type_id"],
    name: json["name"],
    businessName: json["business_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    location: json["location"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    description: json["description"],
    photo: json["photo"],
    rate: json["rate"].toDouble(),
    facebook: json["facebook"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    linkedIn: json["linkedIn"],
    telegram: json["telegram"],
    canRate: json["can_rate"],
    city: BusinessType.fromJson(json["city"]),
    network: BusinessType.fromJson(json["network"]),
    businessType: BusinessType.fromJson(json["business_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city_id": cityId,
    "network_id": networkId,
    "business_type_id": businessTypeId,
    "name": name,
    "business_name": businessName,
    "email": email,
    "phone_number": phoneNumber,
    "location": location,
    "longitude": longitude,
    "latitude": latitude,
    "description": description,
    "photo": photo,
    "rate": rate,
    "facebook": facebook,
    "instagram": instagram,
    "youtube": youtube,
    "linkedIn": linkedIn,
    "telegram": telegram,
    "can_rate": canRate,
    "city": city.toJson(),
    "network": network.toJson(),
    "business_type": businessType.toJson(),
  };
}

class BusinessType {
  BusinessType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
