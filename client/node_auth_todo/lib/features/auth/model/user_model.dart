class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }
}
