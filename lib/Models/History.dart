// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory History.fromJson(Map<String, dynamic> json) => History(
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
    this.totalCount
  });

  int totalValue;
  int totalCount;
  List<HistoryElement> history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalValue: json["total_value"] == null ? null : json["total_value"],
    history: json["history"] == null ? null : List<HistoryElement>.from(json["history"].map((x) => HistoryElement.fromJson(x))),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "total_value": totalValue == null ? null : totalValue,
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class HistoryElement {
  HistoryElement({
    this.id,
    this.cardId,
    this.serviceProviderId,
    this.value,
    this.createdAt,
    this.card,
  });

  int id;
  int cardId;
  int serviceProviderId;
  String value;
  DateTime createdAt;
  HistoryCard card;

  factory HistoryElement.fromJson(Map<String, dynamic> json) => HistoryElement(
    id: json["id"] == null ? null : json["id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    value: json["value"] == null ? null : json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    card: json["card"] == null ? null : HistoryCard.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "card_id": cardId == null ? null : cardId,
    "service_provider_id": serviceProviderId == null ? null : serviceProviderId,
    "value": value == null ? null : value,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "card": card == null ? null : card.toJson(),
  };
}

class HistoryCard {
  HistoryCard({
    this.id,
    this.userId,
    this.cardId,
    this.salesCenterId,
    this.price,
    this.numberOfCoupons,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.card,
  });

  int id;
  int userId;
  int cardId;
  int salesCenterId;
  String price;
  String numberOfCoupons;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  CardCard card;

  factory HistoryCard.fromJson(Map<String, dynamic> json) => HistoryCard(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    salesCenterId: json["sales_center_id"] == null ? null : json["sales_center_id"],
    price: json["price"] == null ? null : json["price"],
    numberOfCoupons: json["number_of_coupons"] == null ? null : json["number_of_coupons"],
    expireAt: json["expire_at"] == null ? null : DateTime.parse(json["expire_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    card: json["card"] == null ? null : CardCard.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "card_id": cardId == null ? null : cardId,
    "sales_center_id": salesCenterId == null ? null : salesCenterId,
    "price": price == null ? null : price,
    "number_of_coupons": numberOfCoupons == null ? null : numberOfCoupons,
    "expire_at": expireAt == null ? null : expireAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "user": user == null ? null : user.toJson(),
    "card": card == null ? null : card.toJson(),
  };
}

class CardCard {
  CardCard({
    this.id,
    this.networkId,
    this.name,
    this.name_en,
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
  String name_en;
  String photo;
  String expireAt;
  String description;
  String price;
  String numberOfCoupons;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory CardCard.fromJson(Map<String, dynamic> json) => CardCard(
    id: json["id"] == null ? null : json["id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    name: json["name"] == null ? null : json["name"],
    name_en: json["name_en"] == null ? null : json["name_en"],
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
