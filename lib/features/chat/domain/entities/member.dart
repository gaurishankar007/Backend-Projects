import '../../../auth/domain/entities/user.dart';

class Member {
  final String id;
  final User user;
  final String nickName;
  final String addedBy;
  final bool admin;
  final String seenMessage;

  const Member({
    required this.id,
    required this.user,
    required this.nickName,
    required this.addedBy,
    required this.admin,
    required this.seenMessage,
  });
}
