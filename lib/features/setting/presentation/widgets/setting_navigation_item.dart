import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/setting_navigator.dart';
import '../arguments/setting_argument.dart';

class SettingNavigationItem extends StatefulWidget {
  final SettingNavigator navigationItem;
  final Color arrowColor;
  final Color valueColor;

  const SettingNavigationItem({
    super.key,
    required this.navigationItem,
    required this.arrowColor,
    required this.valueColor,
  });

  @override
  State<SettingNavigationItem> createState() => _SettingNavigationItemState();
}

class _SettingNavigationItemState extends State<SettingNavigationItem> {
  late final SettingNavigator navigationItem;
  final ValueNotifier<String> notifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    navigationItem = widget.navigationItem;
    notifier.value = widget.navigationItem.value;
  }

  @override
  Widget build(BuildContext context) {
    /// Color of the container containing the leading icon
    Color containerColor = navigationItem.backgroundColor != Colors.transparent
        ? navigationItem.backgroundColor
        : onSurfaceColor(dark: Colors.black, light: const Color(0XFF595959));

    return ListTile(
      onTap: () {
        final argument = SettingArgument(
          onChange: (newValue) => notifier.value = newValue,

          /// Whenever notifier value is changed, then it will be passed again in the new page
          navigator: navigationItem.copyWith(value: notifier.value),
        );
        Navigator.pushNamed(context, navigationItem.routePath, arguments: argument);
      },
      horizontalTitleGap: 8,
      leading: Container(
        padding: EdgeInsets.all(padding5),
        decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
        child: Icon(navigationItem.iconData, size: 18, color: white),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(navigationItem.title, style: largeRegular()),
          ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, newValue, child) {
              return Text(newValue.capitalize, style: largeRegular(widget.valueColor));
            },
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: widget.arrowColor, size: 15),
    );
  }
}
