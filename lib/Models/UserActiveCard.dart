// To parse this JSON data, do
//
//     final userActiveCardModel = userActiveCardModelFromJson(jsonString);

import 'dart:convert';

UserActiveCardModel userActiveCardModelFromJson(String str) => UserActiveCardModel.fromJson(json.decode(str));

String userActiveCardModelToJson(UserActiveCardModel data) => json.encode(data.toJson());

class UserActiveCardModel {
  UserActiveCardModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory UserActiveCardModel.fromJson(Map<String, dynamic> json) => UserActiveCardModel(
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
    this.userId,
    this.cardId,
    this.salesCenterId,
    this.price,
    this.numberOfCoupons,
    this.expireAt,
    this.card,
  });

  int id;
  int userId;
  int cardId;
  int salesCenterId;
  String price;
  String numberOfCoupons;
  DateTime expireAt;
  SelectedCard card;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    salesCenterId: json["sales_center_id"] == null ? null : json["sales_center_id"],
    price: json["price"] == null ? null : json["price"],
    numberOfCoupons: json["number_of_coupons"] == null ? null : json["number_of_coupons"],
    expireAt: json["expire_at"] == null ? null : DateTime.parse(json["expire_at"]),
    card: json["card"] == null ? null : SelectedCard.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "card_id": cardId == null ? null : cardId,
    "sales_center_id": salesCenterId == null ? null : salesCenterId,
    "price": price == null ? null : price,
    "number_of_coupons": numberOfCoupons == null ? null : numberOfCoupons,
    "expire_at": expireAt == null ? null : expireAt.toIso8601String(),
    "card": card == null ? null : card.toJson(),
  };
}

class SelectedCard {
  SelectedCard({
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
    this.nameEn
  });

  int id;
  int networkId;
  String name;
  String nameEn;
  String photo;
  String expireAt;
  String description;
  String price;
  String numberOfCoupons;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory SelectedCard.fromJson(Map<String, dynamic> json) => SelectedCard(
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
    nameEn: json["name_en"]
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
