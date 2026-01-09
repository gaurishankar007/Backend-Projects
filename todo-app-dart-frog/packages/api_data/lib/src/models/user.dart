import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId? id;
  final String name;
  final String email;
  final String password;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.profilePicture,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'password': password,
    'profilePicture': profilePicture,
    'createdAt': createdAt.toIso8601String(),
  };

  Map<String, dynamic> toSafeJson() => {
    'id': id?.oid,
    'name': name,
    'email': email,
    'profilePicture': profilePicture,
    'createdAt': createdAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] as ObjectId?,
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    profilePicture: json['profilePicture'] as String?,
    createdAt: json['createdAt'] is String
        ? DateTime.parse(json['createdAt'] as String)
        : (json['createdAt'] as DateTime?) ?? DateTime.now(),
  );
}
