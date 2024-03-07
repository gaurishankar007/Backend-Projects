import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/routes_data.dart';
import '../../../../../core/resources/data_state.dart';
import '../../features/auth/data/isarCollections/userSetting/user_setting_collection.dart';
import '../../features/auth/data/models/userData/user_data_model.dart';
import '../../features/auth/injection/auth_injector.dart';
import '../../features/dashboard/data/models/settingNavigation/setting_navigation_model.dart';

class UserService with ThemeModeFromValue {
  UserService._();
  static final _singleton = UserService._();
  factory UserService() => _singleton;

  bool _isLoggedIn = true;
  UserDataModel userData = UserDataModel.empty();
  List<UserSettingCollection> _userSettings = [];
  ThemeMode themeMode = ThemeMode.light;

  final List<SettingNavigationModel> _navigationModels = [
    const SettingNavigationModel(
      id: 1,
      title: "Dark Mode",
      subtitle: "",
      value: "System",
      backgroundColor: Colors.transparent,
      iconData: Icons.dark_mode_rounded,
      routePath: kDarkModePath,
    ),
    SettingNavigationModel(
      id: 2,
      title: "Active Status",
      subtitle: "",
      value: "On",
      backgroundColor: green,
      iconData: Icons.contactless_rounded,
      routePath: kActiveStatusPath,
    ),
    SettingNavigationModel(
      id: 3,
      title: "App Lock",
      subtitle: "",
      value: "Off",
      backgroundColor: primaryColor,
      iconData: Icons.lock_rounded,
      routePath: kDarkModePath,
    ),
    SettingNavigationModel(
      id: 4,
      title: "Notifications and Sound",
      subtitle: "",
      value: "On",
      backgroundColor: purple,
      iconData: Icons.notifications_rounded,
      routePath: kDarkModePath,
    )
  ];

  initializeUserData() async {
    await getUserData();
    await getUserSetting();
    applyUserSetting();
  }

  getUserData() async {
    final userDataState = await getUserDataUseCase.call();
    if (userDataState is DataSuccessSate) return userData = userDataState.data!;
    _isLoggedIn = false;
  }

  getUserSetting() async {
    final dataState = await getUserSettingUseCase.call();
    if (dataState is DataSuccessSate) _userSettings = dataState.data!;
  }

  /// Applying the setting that the user has saved before
  applyUserSetting() {
    if (_userSettings.isEmpty) return;
    for (int i = 0; i < _navigationModels.length; i++) {
      final model = _navigationModels[i];

      /// Finding the saved value of the exact model
      int index = _userSettings.indexWhere((element) => element.id == model.id);
      if (index != -1) {
        String newValue = _userSettings[index].value;
        _navigationModels[i] = model.copyWith(value: newValue);
      }
    }

    themeMode = getThemeMode(navigationModels.first.value);
  }

  bool get isLoggedIn => _isLoggedIn;
  List<SettingNavigationModel> get navigationModels => _navigationModels;
}

mixin ThemeModeFromValue {
  ThemeMode getThemeMode(String darkMode) {
    if (darkMode == "On") {
      return ThemeMode.dark;
    } else if (darkMode == "Off") {
      return ThemeMode.light;
    }

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }
}
