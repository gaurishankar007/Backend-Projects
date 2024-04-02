import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/services/user_service.dart';
import '../../domain/entities/setting_navigator.dart';
import '../arguments/setting_argument.dart';
import '../widgets/setting_scaffold.dart';
import '../widgets/setting_values.dart';

class AppLock extends StatefulWidget {
  final SettingArgument parameter;
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
    notifier.value = widget.parameter.navigator.value;
    navigationItem = widget.parameter.navigator;
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
          GetIt.I<UserService>().changeSetting(navigationItem.copyWith(value: newValue));
          widget.parameter.onChange(newValue);
        },
      ),
    );
  }
}
