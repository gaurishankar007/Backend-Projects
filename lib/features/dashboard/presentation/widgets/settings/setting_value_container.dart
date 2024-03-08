import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../injection/injector.dart';
import 'selected_setting.dart';

class SettingValueContainer extends StatelessWidget {
  /// A listenable for rebuilding whenever value gets changed
  final ValueListenable valueListenable;

  /// List of options for selection
  final List values;

  /// A function triggered whenever value gets changed
  final Function(dynamic newValue) onValueSelected;

  const SettingValueContainer({
    super.key,
    required this.valueListenable,
    required this.values,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.propHeight,
        horizontal: screen.horizontalPadding,
      ),
      padding: EdgeInsets.all(padding15),
      decoration: BoxDecoration(
        color: onPopUpColor(context),
        borderRadius: BorderRadius.circular(border10),
      ),
      child: ValueListenableBuilder(
        valueListenable: valueListenable,
        builder: (context, selectedValue, child) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: values.length,
            separatorBuilder: (context, index) => const Divider(height: 30),
            itemBuilder: (context, index) {
              String value = values[index];
              bool selected = value == selectedValue;

              return SettingSelection(
                value: value.capitalize,
                selected: selected,
                onPressed: () {
                  if (selected) return;
                  onValueSelected(value);
                },
              );
            },
          );
        },
      ),
    );
  }
}
