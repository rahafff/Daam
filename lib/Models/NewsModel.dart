// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.message,
    this.data,
    this.code,
  });

  String message;
  List<News> data;
  int code;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<News>.from(json["data"].map((x) => News.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code == null ? null : code,
  };
}

class SingleNews {
  SingleNews({
    this.message,
    this.data,
    this.code,
  });

  String message;
  News data;
  int code;

  factory SingleNews.fromJson(Map<String, dynamic> json) => SingleNews(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : News.fromJson(json["data"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
    "code": code == null ? null : code,
  };
}

class News {
  News({
    this.id,
    this.title,
    this.body,
    this.photo,
  });

  int id;
  String title;
  String body;
  String photo;

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    photo: json["photo"] == null ? null : json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "photo": photo == null ? null : photo,
  };
}
