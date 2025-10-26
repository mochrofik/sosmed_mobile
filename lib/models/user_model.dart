class UserModel {
  final int id;
  final String name;
  final String email;
  final String profile;
  final String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      profile: json['profile'] as String,
      gender: json['gender'] as String,
    );
  }
}
