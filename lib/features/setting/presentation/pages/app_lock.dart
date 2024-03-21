import 'package:flutter/material.dart';

import '../../../../injector/injector.dart';
import '../../domain/entities/setting_navigator.dart';
import '../../domain/parameters/setting_parameter.dart';
import '../widgets/setting_scaffold.dart';
import '../widgets/setting_values.dart';

class AppLock extends StatefulWidget {
  final SettingParameter parameter;
  const AppLock({super.key, required this.parameter});

  @override
  State<AppLock> createState() => _AppLockState();
}

class _AppLockState extends State<AppLock> {
  late final SettingNavigator navigationItem;
  final ValueNotifier<String> notifier = ValueNotifier<String>("");
  final List<String> values = ["on", "off"];

  @override
  void initState() {
    super.initState();
    notifier.value = widget.parameter.navigationItem.value;
    navigationItem = widget.parameter.navigationItem;
  }

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: navigationItem.title,
      body: SettingValues(
        valueListenable: notifier,
        values: values,
        onValueSelected: (newValue) {
          notifier.value = newValue;
          userService.changeSetting(navigationItem.copyWith(value: newValue));
          widget.parameter.onChange(newValue);
        },
      ),
    );
  }
}
