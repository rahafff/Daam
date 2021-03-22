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
  });

  String message;
  Data data;
  int code;

  factory ServiceProviderDetailsModel.fromJson(Map<String, dynamic> json) => ServiceProviderDetailsModel(
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
    this.city,
    this.network,
    this.businessType,
    this.canRate
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
  int canRate;
  BusinessType city;
  BusinessType network;
  BusinessType businessType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    businessTypeId: json["business_type_id"] == null ? null : json["business_type_id"],
    name: json["name"] == null ? null : json["name"],
    businessName: json["business_name"] == null ? null : json["business_name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    location: json["location"] == null ? null : json["location"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    description: json["description"] == null ? null : json["description"],
    photo: json["photo"] == null ? null : json["photo"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
    canRate: json["can_rate"] == null ? null : json["can_rate"],
    city: json["city"] == null ? null : BusinessType.fromJson(json["city"]),
    network: json["network"] == null ? null : BusinessType.fromJson(json["network"]),
    businessType: json["business_type"] == null ? null : BusinessType.fromJson(json["business_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "city_id": cityId == null ? null : cityId,
    "network_id": networkId == null ? null : networkId,
    "business_type_id": businessTypeId == null ? null : businessTypeId,
    "name": name == null ? null : name,
    "business_name": businessName == null ? null : businessName,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "location": location == null ? null : location,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "description": description == null ? null : description,
    "photo": photo == null ? null : photo,
    "rate": rate == null ? null : rate,
    "city": city == null ? null : city.toJson(),
    "network": network == null ? null : network.toJson(),
    "business_type": businessType == null ? null : businessType.toJson(),
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
