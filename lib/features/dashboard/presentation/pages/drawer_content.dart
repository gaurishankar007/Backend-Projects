import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/screen.dart';
import '../../../../widgets/glass/glass_layer_container.dart';
import '../../../../widgets/preferred_size_app_bar.dart';
import '../widgets/drawer/drawer_app_bar_items.dart';
import '../widgets/drawer/drawer_logout_button.dart';
import '../widgets/drawer/drawer_navigation_container.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    /// Listening Theme Changes
    /// It will only rebuild this Scaffold and GlassLayerContainer, not Other Widgets
    /// Because other widgets are built with different context
    Theme.of(context);
    Color backgroundColor = drawerColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSizeAppBar(
        appBar: GlassLayerContainer(
          backgroundColor: backgroundColor,
          height: kToolbarHeight + Screen.statusBarHeight,
          padding: EdgeInsets.only(
            top: Screen.statusBarHeight,
            left: Screen.horizontalPadding,
            right: Screen.horizontalPadding,
          ),
          child: const DrawerAppBarItems(),
        ),
      ),
      body: const DrawerNavigationContainer(),
      floatingActionButton: const DrawerLogoutButton(),
    );
  }
}
