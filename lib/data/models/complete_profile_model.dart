class CompleteProfile {
  final int id;
  final String email;
  final String fullName;
  final String gender;
  final String phone;
  final String country;
  final String birthDate;
  final String role;
  final bool isVerified;
  final String createdAt;
  final String updatedAt;
  final ProfileData? profile;

  CompleteProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.phone,
    required this.country,
    required this.birthDate,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory CompleteProfile.fromJson(Map<String, dynamic> json) {
    return CompleteProfile(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      country: json['your_country'] ?? 'Unknown',
      birthDate: json['birth_date'] ?? 'Unknown',
      role: json['role'] ?? 'Unknown',
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profile: json['profile'] != null
          ? ProfileData.fromJson(Map<String, dynamic>.from(json['profile']))
          : null,
    );
  }
}

class ProfileData {
  final int id;
  final String userEmail;
  final String userName;
  final String avatar;
  final String bio;
  final String website;

  ProfileData({
    required this.id,
    required this.userEmail,
    required this.userName,
    required this.avatar,
    required this.bio,
    required this.website,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? 0,
      userEmail: json['user_email'] ?? '',
      userName: json['user_name'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      website: json['website'] ?? '',
    );
  }
}
