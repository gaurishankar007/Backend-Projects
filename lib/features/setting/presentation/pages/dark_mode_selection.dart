import 'package:flutter/material.dart';

import '../../../../injector/injector.dart';
import '../../../global/domain/enums/dark_mode_enum.dart';
import '../../domain/entities/setting_navigator.dart';
import '../arguments/setting_argument.dart';
import '../widgets/setting_scaffold.dart';
import '../widgets/setting_values.dart';

class DarkModeSelection extends StatefulWidget {
  final SettingArgument argument;
  const DarkModeSelection({super.key, required this.argument});

  @override
  State<DarkModeSelection> createState() => _DarkModeSelectionState();
}

class _DarkModeSelectionState extends State<DarkModeSelection> {
  late final SettingNavigator navigationModel;
  final List<String> darkModes = ["on", "off", "system"];
  final ValueNotifier<String> notifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    navigationModel = widget.argument.navigator;
    notifier.value = navigationModel.value;
  }

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: navigationModel.title,
      body: SettingValues(
        valueListenable: notifier,
        values: darkModes,
        onValueSelected: (newValue) {
          notifier.value = newValue;
          widget.argument.onChange(newValue);
          themeCubit.changeTheme(DarkMode.values.byName(newValue));
          authCubit.changeSetting(navigationModel.copyWith(value: newValue));
        },
      ),
    );
  }
}
