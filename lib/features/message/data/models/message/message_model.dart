// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/types/content_type.dart';
import '../content/content_model.dart';
import '../reaction/reaction_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel extends MessageEntity with _$MessageModel {
  const factory MessageModel({
    @JsonKey(name: "_id") required String id,
    required String chat,
    required String sender,
    required String content,
    required ContentType contentType,
    required List<ReactionModel> reactions,
    @JsonKey(fromJson: ContentModel.fromDynamic) required ContentModel repliedTo,
    required bool pinned,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$$MessageModelImplFromJson(json);
}
