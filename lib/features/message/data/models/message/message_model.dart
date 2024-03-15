// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../global/domain/enums/content_type_enum.dart';
import '../../../domain/entities/message.dart';
import '../messageRepliedUpon/message_short_model.dart';
import '../reaction/reaction_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel extends Message with _$MessageModel {
  const factory MessageModel({
    @JsonKey(name: "_id") required String id,
    required String chat,
    required String sender,
    required String content,
    required ContentType contentType,
    required List<ReactionModel> reactions,
    required MessageRepliedUponModel repliedTo,
    required bool pinned,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$$MessageModelImplFromJson(json);
}
