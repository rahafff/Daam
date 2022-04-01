// To parse this JSON data, do
//
//     final userHistoryModel = userHistoryModelFromJson(jsonString);

import 'dart:convert';

UserHistoryModel userHistoryModelFromJson(String str) => UserHistoryModel.fromJson(json.decode(str));

String userHistoryModelToJson(UserHistoryModel data) => json.encode(data.toJson());

class UserHistoryModel {
  UserHistoryModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  Data data;
  int code;

  factory UserHistoryModel.fromJson(Map<String, dynamic> json) => UserHistoryModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null || (json["data"] is List && json["data"].isEmpty)? null : Data.fromJson(json["data"]),
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
    this.card,
    this.totalUsage
  });

  int id;
  int totalValue;
  var totalUsage;
  List<HistoryUser> history;
  dynamic card;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    totalValue: json["total_value"] == null ? null : json["total_value"],
    history: json["history"] == null ? null : List<HistoryUser>.from(json["history"].map((x) => HistoryUser.fromJson(x))),
    card: json["card"],
    totalUsage: json["total_usage"]
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "total_value": totalValue == null ? null : totalValue,
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
    "card": card,
  };
}

class HistoryUser {
  HistoryUser({
    this.id,
    this.cardId,
    this.serviceProviderId,
    this.value,
    this.createdAt,
    this.card,
    this.serviceProvider
  });

  int id;
  int cardId;
  int serviceProviderId;
  ServiceProvider serviceProvider;
  String value;
  DateTime createdAt;
  HistoryCard card;


  factory HistoryUser.fromJson(Map<String, dynamic> json) => HistoryUser(
    id: json["id"] == null ? null : json["id"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    serviceProviderId: json["service_provider_id"] == null ? null : json["service_provider_id"],
    value: json["value"] == null ? null : json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    card: json["card"] == null ? null : HistoryCard.fromJson(json["card"]),
    serviceProvider: json["service_provider"] == null ? null : ServiceProvider.fromJson(json["service_provider"]),

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
class ServiceProvider {
  ServiceProvider({
    this.id,
    this.cityId,
    this.networkId,
    this.businessTypeId,
    this.name,
    this.businessName_en,
    this.businessName,
    this.email,
    this.phoneNumber,
    this.location,
    this.longitude,
    this.latitude,
    this.description,
    this.photo,
    this.rate,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int cityId;
  int networkId;
  int businessTypeId;
  String name;
  String businessName;
  String businessName_en;
  String email;
  String phoneNumber;
  String location;
  String longitude;
  String latitude;
  String description;
  String photo;
  String rate;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
    id: json["id"] == null ? null : json["id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    networkId: json["network_id"] == null ? null : json["network_id"],
    businessTypeId: json["business_type_id"] == null ? null : json["business_type_id"],
    name: json["name"] == null ? null : json["name"],
    businessName: json["business_name"] == null ? null : json["business_name"],
    businessName_en: json["business_name_en"] == null ? null : json["business_name_en"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    location: json["location"] == null ? null : json["location"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    description: json["description"] == null ? null : json["description"],
    photo: json["photo"] == null ? null : json["photo"],
    rate: json["rate"] == null ? null : json["rate"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
