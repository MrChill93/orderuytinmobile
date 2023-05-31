class UserModel {
  UserModel({
    required this.userName,
    required this.email,
    this.phone,
    this.address,
  });

  String? userName;
  String? email;
  String? phone;
  String? address;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "address": address,
        "phone": phone,
        "email": email,
      };
}
