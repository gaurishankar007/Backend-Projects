import 'user_entity.dart';

class UserData {
  final User user;
  final String accessToken;
  final String refreshToken;
  final ThemeStyle themeStyle;

  const UserData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.themeStyle,
  });
}

enum ThemeStyle { system, light, dark }
