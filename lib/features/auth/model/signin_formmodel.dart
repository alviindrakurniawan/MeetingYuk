
import 'dart:convert';

SigninModel signinModelFromJson(String str) => SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
  String emailPhone;
  String password;

  SigninModel({
    required this.emailPhone,
    required this.password,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
    emailPhone: json["email_phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email_phone": emailPhone,
    "password": password,
  };
}

