import 'package:equatable/equatable.dart';

import '../../../global/domain/enums/content_type_enum.dart';
import 'message_replied_upon.dart';
import 'reaction.dart';

class Message extends Equatable {
  final String id;
  final String chat;
  final String sender;
  final String content;
  final ContentType contentType;
  final List<Reaction> reactions;
  final MessageRepliedUpon repliedTo;
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

  Message copyWith({
    String? id,
    String? chat,
    String? sender,
    String? content,
    ContentType? contentType,
    List<Reaction>? reactions,
    MessageRepliedUpon? repliedTo,
    bool? pinned,
  }) =>
      Message(
        id: id ?? this.id,
        chat: chat ?? this.chat,
        sender: sender ?? this.sender,
        content: content ?? this.content,
        contentType: contentType ?? this.contentType,
        reactions: reactions ?? this.reactions,
        repliedTo: repliedTo ?? this.repliedTo,
        pinned: pinned ?? this.pinned,
      );

  @override
  List<Object?> get props => [
        id,
        chat,
        sender,
        content,
        contentType,
        reactions,
        repliedTo,
        pinned,
      ];
}
