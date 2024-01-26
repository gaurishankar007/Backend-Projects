// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel extends User with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "_id") required String id,
    required String name,
    required String email,
    required String profilePic,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$$UserModelImplFromJson(json);
}
