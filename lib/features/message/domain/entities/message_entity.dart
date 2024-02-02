import '../types/content_type.dart';
import 'content_entity.dart';
import 'reaction_entity.dart';

class MessageEntity {
  final String id;
  final String chat;
  final String sender;
  final String content;
  final ContentType contentType;
  final List<ReactionEntity> reactions;
  final ContentEntity repliedTo;
  final bool pinned;

  const MessageEntity({
    required this.id,
    required this.chat,
    required this.sender,
    required this.content,
    required this.contentType,
    required this.reactions,
    required this.repliedTo,
    required this.pinned,
  });
}
