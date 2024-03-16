import '../../../global/domain/enums/content_type_enum.dart';
import '../../domain/entities/message.dart';
import 'message_replied_upon_model.dart';
import 'reaction_model.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.chat,
    required super.sender,
    required super.content,
    required super.contentType,
    required super.reactions,
    required super.repliedTo,
    required super.pinned,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['_id'] as String,
        chat: json['chat'] as String,
        sender: json['sender'] as String,
        content: json['content'] as String,
        contentType: ContentType.values.byName(json["contentType"]),
        reactions: (json['reactions'] as List<dynamic>)
            .map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        repliedTo: MessageRepliedUponModel.fromJson(json['repliedTo']),
        pinned: json['pinned'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'chat': chat,
        'sender': sender,
        'content': content,
        'contentType': contentType.toString(),
        'reactions': reactions,
        'repliedTo': repliedTo,
        'pinned': pinned,
      };
}
