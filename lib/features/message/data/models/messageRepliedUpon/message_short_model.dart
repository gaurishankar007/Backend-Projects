// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message_replied_to.dart';

part 'message_short_model.freezed.dart';
part 'message_short_model.g.dart';

@freezed
class MessageRepliedUponModel extends MessageRepliedTo with _$MessageRepliedUponModel {
  const factory MessageRepliedUponModel({
    @JsonKey(name: "_id") required String messageId,
    required String content,
    required String contentType,
  }) = _MessageRepliedUponModel;

  factory MessageRepliedUponModel.empty() =>
      const MessageRepliedUponModel(messageId: "", content: "", contentType: "");

  factory MessageRepliedUponModel.fromJson(dynamic value) =>
      MessageRepliedUponModel.fromDynamic(value);

  factory MessageRepliedUponModel.fromDynamic(dynamic value) {
    MessageRepliedUponModel contentModel = MessageRepliedUponModel.empty();
    if (value == null) return contentModel;
    if (value is String) return contentModel.copyWith(messageId: value);
    return _$$MessageRepliedUponModelImplFromJson(value);
  }
}
