import '../../data/models/settingNavigation/setting_navigation_model.dart';

class SettingParameter {
  final Function(String) onChange;
  final SettingNavigationModel navigationItem;

  const SettingParameter({required this.onChange, required this.navigationItem});
}
