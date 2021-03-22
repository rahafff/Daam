// To parse this JSON data, do
//
//     final couponHistoryModel = couponHistoryModelFromJson(jsonString);

import 'dart:convert';

CouponHistoryModel couponHistoryModelFromJson(String str) => CouponHistoryModel.fromJson(json.decode(str));

String couponHistoryModelToJson(CouponHistoryModel data) => json.encode(data.toJson());

class CouponHistoryModel {
  CouponHistoryModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory CouponHistoryModel.fromJson(Map<String, dynamic> json) => CouponHistoryModel(
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
    this.totalValue,
    this.history,
    this.remainingCoupons,
    this.totalCount
  });

  int totalValue;
  int totalCount;
  int remainingCoupons;
  List<ServiceCouponHistory> history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalValue: json["total_value"] == null ? null : json["total_value"],
    history: json["history"] == null ? null : List<ServiceCouponHistory>.from(json["history"].map((x) => ServiceCouponHistory.fromJson(x))),
    totalCount: json["total_count"],
    remainingCoupons: json["remaining_coupons"]
  );

  Map<String, dynamic> toJson() => {
    "total_value": totalValue == null ? null : totalValue,
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class ServiceCouponHistory {
  ServiceCouponHistory({
    this.id,
    this.couponId,
    this.userId,
    this.serviceProviderId,
    this.value,
    this.createdAt,
    this.user,
    this.coupon,
  });

  int id;
  int couponId;
  int userId;
  int serviceProviderId;
  String value;
  DateTime createdAt;
  User user;
  SelectedCoupon coupon;

  factory ServiceCouponHistory.fromJson(Map<String, dynamic> json) => ServiceCouponHistory(
    id: json["id"] == null ? null : json["id"],
    couponId: json["coupon_id"] == null ? null : json["coupon_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    value: json["value"] == null ? null : json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    coupon: json["coupon"] == null ? null : SelectedCoupon.fromJson(json["coupon"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "coupon_id": couponId == null ? null : couponId,
    "user_id": userId == null ? null : userId,
    "service_provider_id": serviceProviderId == null ? null : serviceProviderId,
    "value": value == null ? null : value,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "user": user == null ? null : user.toJson(),
    "coupon": coupon == null ? null : coupon.toJson(),
  };
}

class SelectedCoupon {
  SelectedCoupon({
    this.id,
    this.applicationId,
    this.serviceProviderId,
    this.cardId,
    this.name,
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

  factory SelectedCoupon.fromJson(Map<String, dynamic> json) => SelectedCoupon(
    id: json["id"] == null ? null : json["id"],
    applicationId: json["application_id"] == null ? null : json["application_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    name: json["name"] == null ? null : json["name"],
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

class User {
  User({
    this.id,
    this.cityId,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.serialNumber,
    this.deviceType,
    this.status,
    this.createdAt,
    this.updatedAt,
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
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    gender: json["gender"] == null ? null : json["gender"],
    serialNumber: json["serial_number"] == null ? null : json["serial_number"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
