// To parse this JSON data, do
//
//     final userCouponHistoryModel = userCouponHistoryModelFromJson(jsonString);

import 'dart:convert';

UserCouponHistoryModel userCouponHistoryModelFromJson(String str) => UserCouponHistoryModel.fromJson(json.decode(str));

String userCouponHistoryModelToJson(UserCouponHistoryModel data) => json.encode(data.toJson());

class UserCouponHistoryModel {
  UserCouponHistoryModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory UserCouponHistoryModel.fromJson(Map<String, dynamic> json) => UserCouponHistoryModel(
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
    this.totalValue,
    this.history,
  });

  int id;
  int totalValue;
  List<CouponHistory> history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    totalValue: json["total_value"] == null ? null : json["total_value"],
    history: json["history"] == null ? null : List<CouponHistory>.from(json["history"].map((x) => CouponHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "total_value": totalValue == null ? null : totalValue,
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class CouponHistory {
  CouponHistory({
    this.id,
    this.couponId,
    this.userId,
    this.serviceProviderId,
    this.value,
    this.createdAt,
    this.coupon,
  });

  int id;
  int couponId;
  int userId;
  int serviceProviderId;
  String value;
  DateTime createdAt;
  Coupon coupon;

  factory CouponHistory.fromJson(Map<String, dynamic> json) => CouponHistory(
    id: json["id"] == null ? null : json["id"],
    couponId: json["coupon_id"] == null ? null : json["coupon_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    value: json["value"] == null ? null : json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "coupon_id": couponId == null ? null : couponId,
    "user_id": userId == null ? null : userId,
    "service_provider_id": serviceProviderId == null ? null : serviceProviderId,
    "value": value == null ? null : value,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "coupon": coupon == null ? null : coupon.toJson(),
  };
}

class Coupon {
  Coupon({
    this.id,
    this.applicationId,
    this.serviceProviderId,
    this.cardId,
    this.name,
    this.name_en,
    this.expireAt,
    this.numberOfUsage,
    this.description,
    this.reservationPeriod,
    this.image,
    this.number,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.card,
  });

  int id;
  int applicationId;
  int serviceProviderId;
  int cardId;
  String name;
  String name_en;
  String expireAt;
  int numberOfUsage;
  String description;
  String reservationPeriod;
  String image;
  int number;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Card card;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"] == null ? null : json["id"],
    applicationId: json["application_id"] == null ? null : json["application_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    name: json["name"] == null ? null : json["name"],
    name_en: json["name_en"] == null ? null : json["name_en"],
    expireAt: json["expire_at"] == null ? null : json["expire_at"],
    numberOfUsage: json["number_of_usage"] == null ? null : json["number_of_usage"],
    description: json["description"] == null ? null : json["description"],
    reservationPeriod: json["reservation_period"] == null ? null : json["reservation_period"],
    image: json["image"] == null ? null : json["image"],
    number: json["number"] == null ? null : json["number"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    card: json["card"] == null ? null : Card.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "application_id": applicationId == null ? null : applicationId,
    "service_provider_id": serviceProviderId == null ? null : serviceProviderId,
    "card_id": cardId == null ? null : cardId,
    "name": name == null ? null : name,
    "expire_at": expireAt == null ? null : expireAt,
    "number_of_usage": numberOfUsage == null ? null : numberOfUsage,
    "description": description == null ? null : description,
    "reservation_period": reservationPeriod == null ? null : reservationPeriod,
    "image": image == null ? null : image,
    "number": number == null ? null : number,
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "card": card == null ? null : card.toJson(),
  };
}

class Card {
  Card({
    this.id,
    this.networkId,
    this.name,
    this.photo,
    this.expireAt,
    this.description,
    this.price,
    this.numberOfCoupons,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int networkId;
  String name;
  String photo;
  String expireAt;
  String description;
  String price;
  String numberOfCoupons;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"] == null ? null : json["id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    name: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    expireAt: json["expire_at"] == null ? null : json["expire_at"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    numberOfCoupons: json["number_of_coupons"] == null ? null : json["number_of_coupons"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "network_id": networkId == null ? null : networkId,
    "name": name == null ? null : name,
    "photo": photo == null ? null : photo,
    "expire_at": expireAt == null ? null : expireAt,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "number_of_coupons": numberOfCoupons == null ? null : numberOfCoupons,
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
