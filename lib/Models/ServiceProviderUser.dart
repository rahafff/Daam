// // To parse this JSON data, do
// //
// //     final serviceProviderUser = serviceProviderUserFromJson(jsonString);
//
// import 'dart:convert';
//
// ServiceProviderUser serviceProviderUserFromJson(String str) => ServiceProviderUser.fromJson(json.decode(str));
//
// String serviceProviderUserToJson(ServiceProviderUser data) => json.encode(data.toJson());
//
// class ServiceProviderUser {
//   ServiceProviderUser({
//     this.message,
//     this.data,
//     this.code,
//   });
//
//   String message;
//   Data data;
//   int code;
//
//   factory ServiceProviderUser.fromJson(Map<String, dynamic> json) => ServiceProviderUser(
//     message: json["message"] == null ? null : json["message"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     code: json["code"] == null ? null : json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message == null ? null : message,
//     "data": data == null ? null : data.toJson(),
//     "code": code == null ? null : code,
//   };
// }
//
// class Data {
//   Data({
//     this.id,
//     this.cityId,
//     this.networkId,
//     this.businessTypeId,
//     this.name,
//     this.businessName,
//     this.email,
//     this.phoneNumber,
//     this.location,
//     this.longitude,
//     this.latitude,
//     this.description,
//     this.photo,
//     this.rate,
//     this.apiToken,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int id;
//   int cityId;
//   int networkId;
//   int businessTypeId;
//   String name;
//   String businessName;
//   String email;
//   String phoneNumber;
//   String location;
//   String longitude;
//   String latitude;
//   String description;
//   String photo;
//   String rate;
//   String apiToken;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"] == null ? null : json["id"],
//     cityId: json["city_id"] == null ? null : json["city_id"],
//     networkId: json["network_id"] == null ? null : json["network_id"],
//     businessTypeId: json["business_type_id"] == null ? null : json["business_type_id"],
//     name: json["name"] == null ? null : json["name"],
//     businessName: json["business_name"] == null ? null : json["business_name"],
//     email: json["email"] == null ? null : json["email"],
//     phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
//     location: json["location"] == null ? null : json["location"],
//     longitude: json["longitude"] == null ? null : json["longitude"],
//     latitude: json["latitude"] == null ? null : json["latitude"],
//     description: json["description"] == null ? null : json["description"],
//     photo: json["photo"] == null ? null : json["photo"],
//     rate: json["rate"] == null ? null : json["rate"],
//     apiToken: json["api_token"] == null ? null : json["api_token"],
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "city_id": cityId == null ? null : cityId,
//     "network_id": networkId == null ? null : networkId,
//     "business_type_id": businessTypeId == null ? null : businessTypeId,
//     "name": name == null ? null : name,
//     "business_name": businessName == null ? null : businessName,
//     "email": email == null ? null : email,
//     "phone_number": phoneNumber == null ? null : phoneNumber,
//     "location": location == null ? null : location,
//     "longitude": longitude == null ? null : longitude,
//     "latitude": latitude == null ? null : latitude,
//     "description": description == null ? null : description,
//     "photo": photo == null ? null : photo,
//     "rate": rate == null ? null : rate,
//     "api_token": apiToken == null ? null : apiToken,
//     "deleted_at": deletedAt,
//     "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//     "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//   };
// }
