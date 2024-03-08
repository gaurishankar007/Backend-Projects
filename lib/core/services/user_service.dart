import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/routes_data.dart';
import '../../../../../core/resources/data_state.dart';
import '../../features/auth/data/isarCollections/userSetting/user_setting_collection.dart';
import '../../features/auth/data/models/userData/user_data_model.dart';
import '../../features/auth/injection/auth_injector.dart';
import '../../features/dashboard/data/models/settingNavigation/setting_navigation_model.dart';
import '../../features/global/domain/enums/dark_mode_enum.dart';
import '../../features/global/presentations/mixins/dark_mode_mixin.dart';

class UserService with DarkModeMixin {
  UserService._();
  static final _singleton = UserService._();
  factory UserService() => _singleton;

  bool _isLoggedIn = true;
  UserDataModel userData = UserDataModel.empty();
  List<UserSettingCollection> _userSettings = [];

  final List<SettingNavigationModel> _navigationModels = [
    const SettingNavigationModel(
      id: 1,
      title: "Dark Mode",
      subtitle: "",
      value: "system",
      backgroundColor: Colors.transparent,
      iconData: Icons.dark_mode_rounded,
      routePath: kDarkModePath,
    ),
    SettingNavigationModel(
      id: 2,
      title: "Active Status",
      subtitle: "",
      value: "on",
      backgroundColor: green,
      iconData: Icons.contactless_rounded,
      routePath: kActiveStatusPath,
    ),
    SettingNavigationModel(
      id: 3,
      title: "App Lock",
      subtitle: "",
      value: "off",
      backgroundColor: primaryColor,
      iconData: Icons.lock_rounded,
      routePath: kAppLockPath,
    ),
    SettingNavigationModel(
      id: 4,
      title: "Notifications and Sound",
      subtitle: "",
      value: "on",
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
  }

  /// Set new user setting
  changeSetting(SettingNavigationModel newModel) {
    /// Finding Index of the old model
    final index = _navigationModels.indexWhere((element) => element.id == newModel.id);
    if (index == -1) return;

    /// Updating data
    _navigationModels[index] = newModel;

    /// Saving new setting
    saveUserSettingUseCase.call(newModel);
  }

  bool get isLoggedIn => _isLoggedIn;
  List<SettingNavigationModel> get navigationModels => _navigationModels;
  ThemeMode get themeMode => getThemeMode(DarkMode.values.byName(navigationModels.first.value));
}
