import 'user.dart';

class UserData {
  final User user;
  final String accessToken;
  final String refreshToken;

  const UserData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}
