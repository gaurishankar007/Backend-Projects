import '../../domain/entities/setting_navigator.dart';

/// Holds data for changing individual setting
class SettingArgument {
  final Function(String) onChange;
  final SettingNavigator navigator;

  const SettingArgument({required this.onChange, required this.navigator});
}
