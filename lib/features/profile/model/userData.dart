class UserData {
  String name;
  String email;
  String phone;
  String profileImageUrl;
  int isMerchant;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.isMerchant,
  });

  UserData copyWith({
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    int? isMerchant,
  }) =>
      UserData(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        isMerchant: isMerchant ?? this.isMerchant,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["data"]["name"],
    email: json["data"]["email"],
    phone: json["data"]["phone"],
    profileImageUrl: json["data"]["profile_image_url"],
    isMerchant: json["data"]["is_merchant"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "profile_image_url": profileImageUrl,
    "is_merchant": isMerchant,
  };
}
