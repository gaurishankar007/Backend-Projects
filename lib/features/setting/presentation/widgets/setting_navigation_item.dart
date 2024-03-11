import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/utils/text_styles.dart';
import '../../data/models/settingNavigation/setting_navigation_model.dart';
import '../../domain/parameters/setting_parameter.dart';

class SettingNavigationItem extends StatefulWidget {
  final SettingNavigationModel navigationItem;
  const SettingNavigationItem({super.key, required this.navigationItem});

  @override
  State<SettingNavigationItem> createState() => _SettingNavigationItemState();
}

class _SettingNavigationItemState extends State<SettingNavigationItem> {
  late final SettingNavigationModel navigationItem;
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
        : context.onSurfaceColor(dark: Colors.black, light: const Color(0XFF595959));
    Color arrowColor =
        context.surfaceColor(dark: const Color(0XFF595959), light: const Color(0XFFCCCCCC));
    Color valueColor =
        context.onSurfaceColor(light: const Color(0XFF888888), dark: const Color(0XFF808080));

    return ListTile(
      onTap: () {
        final argument = SettingParameter(
          onChange: (newValue) => notifier.value = newValue,
          navigationItem: navigationItem,
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
              return Text(newValue.capitalize, style: largeRegular(valueColor));
            },
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: arrowColor, size: 15),
    );
  }
}
