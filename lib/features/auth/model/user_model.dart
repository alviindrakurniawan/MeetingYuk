import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int code;
  bool status;
  String message;
  Data data;

  UserModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  UserModel copyWith({
    int? code,
    bool? status,
    String? message,
    Data? data,
  }) =>
      UserModel(
        code: code ?? this.code,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String name;
  String email;
  String phone;
  String profileImageUrl;
  int isMerchant;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.isMerchant,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    int? isMerchant,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        isMerchant: isMerchant ?? this.isMerchant,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profileImageUrl: json["profile_image_url"],
    isMerchant: json["is_merchant"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_image_url": profileImageUrl,
    "is_merchant": isMerchant,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}