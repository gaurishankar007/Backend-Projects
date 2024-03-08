import 'package:flutter/material.dart';

import '../../../../../injection/injector.dart';
import '../../../data/models/settingNavigation/setting_navigation_model.dart';
import '../../widgets/settings/setting_scaffold.dart';
import '../../widgets/settings/setting_value_container.dart';

class ActiveStatus extends StatelessWidget {
  final SettingNavigationModel navigationModel;
  ActiveStatus({super.key, required this.navigationModel});

  final ValueNotifier<String> notifier = ValueNotifier<String>("");
  final List<String> values = ["on", "off"];

  @override
  Widget build(BuildContext context) {
    notifier.value = navigationModel.value;

    return SettingScaffold(
      appBarTitle: navigationModel.title,
      body: SettingValueContainer(
        valueListenable: notifier,
        values: values,
        onValueSelected: (newValue) {
          notifier.value = newValue;
          settingCubit.changeSetting(navigationModel.copyWith(value: newValue));
        },
      ),
    );
  }
}
