import 'user_entity.dart';

class UserDataEntity {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;
  final ThemeStyle themeStyle;

  const UserDataEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.themeStyle,
  });
}

enum ThemeStyle { system, light, dark }
