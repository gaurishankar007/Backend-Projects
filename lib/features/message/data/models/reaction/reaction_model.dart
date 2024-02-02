// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/reaction_entity.dart';

part 'reaction_model.freezed.dart';
part 'reaction_model.g.dart';

@freezed
class ReactionModel extends ReactionEntity with _$ReactionModel {
  const factory ReactionModel({
    @JsonKey(name: "_id") required String id,
    required String reaction,
    required String user,
  }) = _ReactionModel;

  factory ReactionModel.fromJson(Map<String, dynamic> json) => _$$ReactionModelImplFromJson(json);
}
