class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "role": role,
    };
  }
}
