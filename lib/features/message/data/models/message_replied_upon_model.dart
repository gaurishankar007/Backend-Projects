import '../../domain/entities/message_replied_upon.dart';

class MessageRepliedUponModel extends MessageRepliedUpon {
  const MessageRepliedUponModel({
    required super.messageId,
    required super.content,
    required super.contentType,
  });

  factory MessageRepliedUponModel.empty() =>
      const MessageRepliedUponModel(messageId: "", content: "", contentType: "");

  factory MessageRepliedUponModel.fromJson(dynamic value) {
    if (value == null) return MessageRepliedUponModel.empty();

    if (value is String) {
      return MessageRepliedUponModel(messageId: value, content: "", contentType: "");
    }

    return MessageRepliedUponModel(
      messageId: value['_id'] as String,
      content: value['content'] as String,
      contentType: value['contentType'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': messageId,
        'content': content,
        'contentType': contentType,
      };
}
