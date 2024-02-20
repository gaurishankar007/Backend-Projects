import '../../../global/domain/enums/theme_style_enum.dart';
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
