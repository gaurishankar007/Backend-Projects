import 'package:mongo_dart/mongo_dart.dart';

class Todo {
  final ObjectId? id;
  final String userId;
  final String title;
  final String? description;
  final bool completed;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Todo({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    this.completed = false,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'completed': completed,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['_id'] as ObjectId?,
    userId: json['userId'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    completed: json['completed'] as bool? ?? false,
    createdAt: json['createdAt'] is String
        ? DateTime.parse(json['createdAt'] as String)
        : (json['createdAt'] as DateTime?) ?? DateTime.now(),
    updatedAt: json['updatedAt'] is String
        ? DateTime.parse(json['updatedAt'] as String)
        : json['updatedAt'] as DateTime?,
  );

  Todo copyWith({
    ObjectId? id,
    String? userId,
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Todo(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    description: description ?? this.description,
    completed: completed ?? this.completed,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
