import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../../../../widgets/buttons/custom_icon_button.dart';
import '../../../../widgets/glass/glass_layer_container.dart';
import '../../../../widgets/preferred_size_app_bar.dart';

class SettingScaffold extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  final bool showLeading;

  const SettingScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    /// Listening Theme Changes
    Theme.of(context);
    Color backgroundColor = popUpColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSizeAppBar(
        appBar: GlassLayerContainer(
          backgroundColor: backgroundColor,
          height: kToolbarHeight,
          padding: EdgeInsets.symmetric(horizontal: screen.horizontalPadding),
          child: Stack(
            children: [
              if (showLeading)
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: primaryColor,
                      size: appBarIconSize,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.center,
                child: Text(appBarTitle, style: largeSemibold()),
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
        ),
      ),
      body: body,
    );
  }
}
