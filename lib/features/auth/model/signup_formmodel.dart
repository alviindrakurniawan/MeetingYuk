import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String name;
  String email;
  String phone;
  String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
  };
}
