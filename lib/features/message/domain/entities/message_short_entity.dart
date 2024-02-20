/// A message is replied to this another message
/// This is the class to store the data of another message
class MessageShortEntity {
  final String messageId;
  final String content;
  final String contentType;

  const MessageShortEntity({
    required this.messageId,
    required this.content,
    required this.contentType,
  });
}
