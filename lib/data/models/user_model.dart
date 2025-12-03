class RegisterUserModel {
  final String? status;
  final String? message;
  final String? access;
  final String? refresh;
  final User? user;

  RegisterUserModel({
    this.status,
    this.message,
    this.access,
    this.refresh,
    this.user,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final userJson = data['user'] ?? {};

    return RegisterUserModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      access: data['access'] as String?,
      refresh: data['refresh'] as String?,
      user: User.fromJson(userJson),
    );
  }
}

class User {
  final int? id;
  final String? full_name;
  final String? email;
  final String? your_country;
  final String? gender;
  final String? phone;
  final String? birth_date;
  final String? role;
  final bool? is_verified;
  final String? created_at;
  final String? updated_at;

  User({
    this.id,
    this.full_name,
    this.email,
    this.your_country,
    this.gender,
    this.phone,
    this.birth_date,
    this.role,
    this.is_verified,
    this.created_at,
    this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      full_name: json['full_name'] as String?,
      email: json['email'] as String?,
      your_country: json['your_country'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      birth_date: json['birth_date'] as String?,
      role: json['role'] as String?,
      is_verified: json['is_verified'] as bool?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );
  }
}
