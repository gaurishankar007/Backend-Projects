/// A message is replied to this another message
/// This is the class to store the data of another message
class MessageRepliedTo {
  final String messageId;
  final String content;
  final String contentType;

  const MessageRepliedTo({
    required this.messageId,
    required this.content,
    required this.contentType,
  });
}
