// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel extends UserEntity with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "_id") required String id,
    required String name,
    required String email,
    required String profile,
  }) = _UserModel;

  factory UserModel.fromJson(dynamic value) => UserModel.fromIdOrJson(value);

  /// Get user model when only id is available
  /// Other instance properties are empty
  factory UserModel.fromId(String id) => UserModel(id: id, name: "", email: "", profile: "");

  factory UserModel.fromIdOrJson(dynamic value) =>
      value is String ? UserModel.fromId(value) : _$$UserModelImplFromJson(value);
}
