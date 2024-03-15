import '../../../global/domain/enums/content_type_enum.dart';
import 'message_replied_to.dart';
import 'reaction.dart';

class Message {
  final String id;
  final String chat;
  final String sender;
  final String content;
  final ContentType contentType;
  final List<Reaction> reactions;
  final MessageRepliedTo repliedTo;
  final bool pinned;

  const Message({
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
