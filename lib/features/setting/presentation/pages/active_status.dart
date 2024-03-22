import 'package:flutter/material.dart';

import '../../../../injector/injector.dart';
import '../../domain/entities/setting_navigator.dart';
import '../arguments/setting_argument.dart';
import '../widgets/setting_scaffold.dart';
import '../widgets/setting_values.dart';

class ActiveStatus extends StatefulWidget {
  final SettingArgument argument;
  const ActiveStatus({super.key, required this.argument});

  @override
  State<ActiveStatus> createState() => _ActiveStatusState();
}

class _ActiveStatusState extends State<ActiveStatus> {
  late final SettingNavigator navigator;
  final ValueNotifier<String> notifier = ValueNotifier<String>("");
  final List<String> values = ["on", "off"];

  @override
  void initState() {
    super.initState();
    notifier.value = widget.argument.navigator.value;
    navigator = widget.argument.navigator;
  }

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: navigator.title,
      body: SettingValues(
        valueListenable: notifier,
        values: values,
        onValueSelected: (newValue) {
          notifier.value = newValue;
          authCubit.changeSetting(navigator.copyWith(value: newValue));
          widget.argument.onChange(newValue);
        },
      ),
    );
  }
}
