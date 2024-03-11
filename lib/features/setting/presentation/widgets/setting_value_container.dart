import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injection/injector.dart';

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

              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  if (selected) return;
                  onValueSelected(value);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value.capitalize, style: largeRegular()),
                    if (selected) Icon(Icons.check_rounded, color: primaryColor, size: 18)
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
