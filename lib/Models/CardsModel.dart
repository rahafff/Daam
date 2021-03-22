// To parse this JSON data, do
//
//     final cardsModel = cardsModelFromJson(jsonString);

import 'dart:convert';

CardsModel cardsModelFromJson(String str) => CardsModel.fromJson(json.decode(str));

String cardsModelToJson(CardsModel data) => json.encode(data.toJson());

class CardsModel {
  CardsModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<CardItem> data;
  int code;

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<CardItem>.from(json["data"].map((x) => CardItem.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}
class CardsDetailsModel {
  CardsDetailsModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  CardItem data;
  int code;

  factory CardsDetailsModel.fromJson(Map<String, dynamic> json) => CardsDetailsModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CardItem.fromJson(json["data"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
    "code": code == null ? null : code,
  };
}

class CardItem {
  CardItem({
    this.id,
    this.networkId,
    this.name,
    this.photo,
    this.expireAt,
    this.description,
    this.price,
    this.network,
    this.active,
    this.activeCardId
  });

  int id;
  int networkId;
  String name;
  String photo;
  String expireAt;
  String description;
  String price;
  Network network;
  String active;
  int activeCardId;

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
    id: json["id"] == null ? null : json["id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    name: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    expireAt: json["expire_at"] == null ? null : json["expire_at"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    active: json["active"] == null ? null : json["active"],
    activeCardId: json["active_card_id"] == null ? null : json["active_card_id"],
    network: json["network"] == null ? null : Network.fromJson(json["network"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "network_id": networkId == null ? null : networkId,
    "name": name == null ? null : name,
    "photo": photo == null ? null : photo,
    "expire_at": expireAt == null ? null : expireAt,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "network": network == null ? null : network.toJson(),
  };
}

class Network {
  Network({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
