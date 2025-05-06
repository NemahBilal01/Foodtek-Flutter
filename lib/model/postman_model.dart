class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? role;
  final String? profilePicture;
  final String? token;
  final String? birthday;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.profilePicture,
    this.token,
    this.birthday,
  });

  factory User.fromLoginJson(Map<String, dynamic> json, String token) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      profilePicture: json['profile_picture'],
      token: token,
      birthday: json['birthday'],
    );
  }

  factory User.fromRegisterJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      birthday: json['birthday'],
    );
  }
}
