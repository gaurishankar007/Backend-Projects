import 'package:flutter/material.dart';

import '../../../../../injection/injector.dart';
import '../../../../global/domain/enums/dark_mode_enum.dart';
import '../../../data/models/settingNavigation/setting_navigation_model.dart';
import '../../widgets/settings/setting_scaffold.dart';
import '../../widgets/settings/setting_value_container.dart';

class DarkModeSelection extends StatefulWidget {
  final SettingNavigationModel navigationModel;
  const DarkModeSelection({super.key, required this.navigationModel});

  @override
  State<DarkModeSelection> createState() => _DarkModeSelectionState();
}

class _DarkModeSelectionState extends State<DarkModeSelection> {
  late final SettingNavigationModel navigationModel;
  final List<String> darkModes = ["on", "off", "system"];
  final ValueNotifier<String> notifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    navigationModel = widget.navigationModel;
    notifier.value = navigationModel.value;
  }

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: navigationModel.title,
      body: SettingValueContainer(
        valueListenable: notifier,
        values: darkModes,
        onValueSelected: (value) {
          notifier.value = value;
          settingCubit.changeSetting(navigationModel.copyWith(value: value));
          themeCubit.changeTheme(DarkMode.values.byName(value));
        },
      ),
    );
  }
}
