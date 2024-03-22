import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/resources/data_state.dart';
import '../../features/auth/domain/entities/user_data.dart';
import '../../features/auth/domain/entities/user_setting.dart';
import '../../features/auth/domain/useCases/get_user_data_uc.dart';
import '../../features/auth/domain/useCases/get_user_setting_uc.dart';
import '../../features/global/domain/enums/dark_mode_enum.dart';
import '../../features/global/presentations/mixins/dark_mode_mixin.dart';
import '../../features/setting/domain/entities/setting_navigator.dart';
import '../navigation/navigator.dart';

/// A class that stores user data
class UserService with DarkModeMixin {
  final GetUserDataUseCase getUserDataUseCase;
  final GetUserSettingUseCase getUserSettingUseCase;

  UserService({
    required this.getUserDataUseCase,
    required this.getUserSettingUseCase,
  });

  bool _isLoggedIn = true;
  UserData userData = const UserData.empty();
  List<UserSetting> _userSettings = [];

  List<SettingNavigator> _navigators = [
    const SettingNavigator(
      id: 1,
      title: "Dark Mode",
      subtitle: "",
      value: "system",
      backgroundColor: Colors.transparent,
      iconData: Icons.dark_mode_rounded,
      routePath: DARK_MODE_PATH,
    ),
    SettingNavigator(
      id: 2,
      title: "Active Status",
      subtitle: "",
      value: "on",
      backgroundColor: green,
      iconData: Icons.contactless_rounded,
      routePath: ACTIVE_STATUS_PATH,
    ),
    SettingNavigator(
      id: 3,
      title: "App Lock",
      subtitle: "",
      value: "off",
      backgroundColor: primaryColor,
      iconData: Icons.lock_rounded,
      routePath: APP_LOCK_PATH,
    ),
    SettingNavigator(
      id: 4,
      title: "Notifications and Sound",
      subtitle: "",
      value: "on",
      backgroundColor: purple,
      iconData: Icons.notifications_rounded,
      routePath: DARK_MODE_PATH,
    )
  ];

  initializeUserData() async {
    await getUserData();
    await getUserSetting();
    applyUserSetting();
  }

  getUserData() async {
    final userDataState = await getUserDataUseCase.call();
    if (userDataState is DataSuccess) return userData = userDataState.data!;
    _isLoggedIn = false;
  }

  getUserSetting() async {
    final dataState = await getUserSettingUseCase.call();
    if (dataState is DataSuccess) _userSettings = dataState.data!;
  }

  /// Applying the setting that the user has saved before
  applyUserSetting() {
    if (_userSettings.isEmpty) return;
    for (int i = 0; i < _navigators.length; i++) {
      final navigator = _navigators[i];

      /// Finding the saved value of the exact navigator
      int index = _userSettings.indexWhere((element) => element.id == navigator.id);
      if (index != -1) {
        String newValue = _userSettings[index].value;
        _navigators[i] = navigator.copyWith(value: newValue);
      }
    }
  }

  /// Set new user setting
  changeSetting(SettingNavigator navigator) =>
      _navigators = _navigators.map((e) => e.id == navigator.id ? navigator : e).toList();

  bool get isLoggedIn => _isLoggedIn;
  List<SettingNavigator> get navigators => _navigators;
  ThemeMode get themeMode => getThemeMode(DarkMode.values.byName(navigators.first.value));
}
