import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/content_entity.dart';
part 'content_model.freezed.dart';
part 'content_model.g.dart';

@freezed
class ContentModel extends ContentEntity with _$ContentModel {
  const factory ContentModel({
    required String messageId,
    required String content,
    required String contentType,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) => _$$ContentModelImplFromJson(json);
  factory ContentModel.empty() => const ContentModel(messageId: "", content: "", contentType: "");
  factory ContentModel.fromDynamic(dynamic value) {
    ContentModel contentModel = ContentModel.empty();
    if (value == null) return contentModel;
    if (value is String) return contentModel.copyWith(messageId: value);
    return ContentModel.fromJson(value);
  }
}
