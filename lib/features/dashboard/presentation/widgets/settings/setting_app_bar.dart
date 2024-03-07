import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/utils/navigator.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../injection/injector.dart';
import '../../../../../widgets/buttons/custom_icon_button.dart';
import '../../../../../widgets/glass_layer.dart';

class SettingAppBar extends StatelessWidget {
  final String title;
  final bool showLeading;

  const SettingAppBar({super.key, required this.title, this.showLeading = true});

  @override
  Widget build(BuildContext context) {
    final Color popUpColor = context.surfaceColor(light: f5f5f5, dark: const Color(0XFF222222));

    return GlassLayer(
      opacity: .05,
      backgroundColor: popUpColor,
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: screen.horizontalPadding),
      child: Stack(
        children: [
          if (showLeading)
            Align(
              alignment: Alignment.centerLeft,
              child: CustomIconButton(
                onPressed: () => popPage(),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: primaryColor,
                  size: appBarIconSize,
                ),
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: Text(title, style: largeSemibold()),
          ),
          if (!showLeading)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => popPage(),
                child: Text("Done", style: largeSemibold()),
              ),
            ),
        ],
      ),
    );
  }
}
