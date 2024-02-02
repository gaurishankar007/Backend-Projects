// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../auth/data/models/user/user_model.dart';
import '../../../domain/entities/member_entity.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
class MemberModel extends MemberEntity with _$MemberModel {
  const factory MemberModel({
    @JsonKey(name: "_id") required String id,
    required UserModel user,
    required String nickName,
    required String addedBy,
    required bool admin,
    required String seenMessage,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$$MemberModelImplFromJson(json);
}
