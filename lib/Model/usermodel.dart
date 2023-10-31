class UserModel {
  String? firstName;
  String? lastName;
  String? email;

  UserModel({this.email, this.firstName, this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        email: map["email"],
        firstName: map["firstName"],
        lastName: map["lastName"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}

