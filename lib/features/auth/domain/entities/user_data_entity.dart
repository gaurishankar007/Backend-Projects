import 'user_entity.dart';

class UserDataEntity {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;

  const UserDataEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}
