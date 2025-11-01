class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? username; // for login
  final String? token;    // for login

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.username,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        age: json['age'] as int?,
        username: json['username'] as String?,
        token: json['token'] as String?,
      );
}
