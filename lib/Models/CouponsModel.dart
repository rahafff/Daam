// To parse this JSON data, do
//
//     final couponsModel = couponsModelFromJson(jsonString);

import 'dart:convert';

CouponsModel couponsModelFromJson(String str) => CouponsModel.fromJson(json.decode(str));

String couponsModelToJson(CouponsModel data) => json.encode(data.toJson());

class CouponsModel {
  CouponsModel({
    this.message,
    this.data,
    this.code,
    this.dataCount
  });

  String message;
  List<Coupon> data;
  int code;
  int dataCount;

  factory CouponsModel.fromJson(Map<String, dynamic> json) => CouponsModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Coupon>.from(json["data"].map((x) => Coupon.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
      dataCount: json['data_count'] == null ? null : json["data_count"]

  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}

class CouponDetailsModel {
  CouponDetailsModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Coupon data;
  int code;

  factory CouponDetailsModel.fromJson(Map<String, dynamic> json) => CouponDetailsModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Coupon.fromJson(json["data"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
    "code": code == null ? null : code,
  };
}
class Coupon {
  Coupon({
    this.id,
    this.serviceProviderId,
    this.cardId,
    this.expireAt,
    this.numberOfUsage,
    this.description,
    this.reservationPeriod,
    this.image,
    this.serviceProvider,
    this.card,
    this.name,
    this.reserved,
    this.number
  });

  int id;
  int serviceProviderId;
  int cardId;
  int reserved;
  String expireAt;
  int numberOfUsage;
  String description;
  String reservationPeriod;
  String image;
  String name;
  ServiceProvider serviceProvider;
  Card card;
  int number;


  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"] == null ? null : json["id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    expireAt: json["expire_at"] == null ? null : json["expire_at"],
    numberOfUsage: json["number_of_usage"] == null ? null : json["number_of_usage"],
    number: json["number"] == null ? null : json["number"],
    description: json["description"] == null ? null : json["description"],
    reservationPeriod: json["reservation_period"] == null ? null : json["reservation_period"],
    image: json["image"] == null ? null : json["image"],
    name: json["name"] == null ? null : json["name"],
    serviceProvider: json["service_provider"] == null ? null : ServiceProvider.fromJson(json["service_provider"]),
    card: json["card"] == null ? null : Card.fromJson(json["card"]),
    reserved: json["reserved"]
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "service_provider_id": serviceProviderId == null ? null : serviceProviderId,
    "card_id": cardId == null ? null : cardId,
    "expire_at": expireAt == null ? null : expireAt,
    "number_of_usage": numberOfUsage == null ? null : numberOfUsage,
    "description": description == null ? null : description,
    "reservation_period": reservationPeriod == null ? null : reservationPeriod,
    "image": image == null ? null : image,
    "service_provider": serviceProvider == null ? null : serviceProvider.toJson(),
    "card": card == null ? null : card.toJson(),
  };
}

class Card {
  Card({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class ServiceProvider {
  ServiceProvider({
    this.id,
    this.businessName,
  });

  int id;
  String businessName;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
    id: json["id"] == null ? null : json["id"],
    businessName: json["business_name"] == null ? null : json["business_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "business_name": businessName == null ? null : businessName,
  };
}
