// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<NotiData> data;
  int code;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    message: json["message"],
    data: List<NotiData>.from(json["data"].map((x) => NotiData.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code,
  };
}

class NotiData {
  NotiData({
    this.id,
    this.text,
    this.createdAt,
  });

  int id;
  String text;
  String createdAt;

  factory NotiData.fromJson(Map<String, dynamic> json) => NotiData(
    id: json["id"],
    text: json["text"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "created_at": createdAt,
  };
}
