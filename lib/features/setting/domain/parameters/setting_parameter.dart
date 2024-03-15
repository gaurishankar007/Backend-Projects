import '../entities/setting_navigator.dart';

class SettingParameter {
  final Function(String) onChange;
  final SettingNavigator navigationItem;

  const SettingParameter({required this.onChange, required this.navigationItem});
}
