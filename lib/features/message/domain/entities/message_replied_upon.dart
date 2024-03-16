import 'package:equatable/equatable.dart';

/// A message is replied to this another message
/// This is the class to store the data of another message
class MessageRepliedUpon extends Equatable {
  final String messageId;
  final String content;
  final String contentType;

  const MessageRepliedUpon({
    required this.messageId,
    required this.content,
    required this.contentType,
  });

  MessageRepliedUpon copyWith({
    String? messageId,
    String? content,
    String? contentType,
  }) =>
      MessageRepliedUpon(
        messageId: messageId ?? this.messageId,
        content: content ?? this.content,
        contentType: contentType ?? this.contentType,
      );

  @override
  List<Object?> get props => [
        messageId,
        content,
        contentType,
      ];
}
