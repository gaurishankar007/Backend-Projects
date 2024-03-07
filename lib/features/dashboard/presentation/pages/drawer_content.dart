import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../injection/injector.dart';
import '../../../../widgets/preferred_size_app_bar.dart';
import '../../data/models/drawer_navigation_model.dart';
import '../widgets/drawer/drawer_app_bar.dart';
import '../widgets/drawer/drawer_logout_button.dart';
import '../widgets/drawer/drawer_navigation_item.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key});

  final List<DrawerNavigationModel> navigationItems = [
    const DrawerNavigationModel(id: 1, name: "Chat", iconData: Icons.chat_bubble_rounded),
    const DrawerNavigationModel(id: 2, name: "Message requests", iconData: Icons.chat_rounded),
    const DrawerNavigationModel(id: 3, name: "Hidden", iconData: Icons.visibility_off_rounded),
  ];
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = context.surfaceColor(
      light: f5f5f5,
      dark: const Color(0XFF575757),
    );
    final Color drawerColor = context.surfaceColor(
      light: Colors.white,
      dark: const Color(0XFF303030),
    );

    return Scaffold(
      backgroundColor: drawerColor,
      appBar: const PreferredSizeAppBar(appBar: DrawerAppBar()),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: screen.horizontalPadding,
              vertical: 15.propHeight,
            ),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: navigationItems.length,
            separatorBuilder: (_, index) => SizedBox(height: 10.propHeight),
            itemBuilder: (context, index) {
              final navigationItem = navigationItems[index];
              final bool selected = index == value;
              final containerColor = selected ? selectedColor : drawerColor;

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => selectedIndex.value = index,
                child: DrawerNavigationItem(
                  navigationItem: navigationItem,
                  backgroundColor: containerColor,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: const DrawerLogoutButton(),
    );
  }
}
