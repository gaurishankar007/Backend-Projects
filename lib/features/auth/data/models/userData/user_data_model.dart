// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user_data_entity.dart';
import '../user/user_model.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
class UserDataModel extends UserData with _$UserDataModel {
  const factory UserDataModel({
    required UserModel user,
    required String accessToken,
    required String refreshToken,
    @Default(ThemeStyle.system) @JsonKey(includeFromJson: false) ThemeStyle themeStyle,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$$UserDataModelImplFromJson(json);
}
