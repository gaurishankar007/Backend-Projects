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

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  final List<DrawerNavigationModel> navigationItems = [
    const DrawerNavigationModel(id: 1, name: "Chat", iconData: Icons.chat_bubble_rounded),
    const DrawerNavigationModel(id: 2, name: "Message requests", iconData: Icons.chat_rounded),
    const DrawerNavigationModel(id: 3, name: "Hidden", iconData: Icons.visibility_off_rounded),
  ];
  final ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = context.surfaceColor(light: f5f5f5, dark: const Color(0XFF575757));

    return Scaffold(
      backgroundColor: drawerColor(context),
      appBar: const PreferredSizeAppBar(appBar: DrawerAppBar()),
      body: ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (context, selectedIndex, child) {
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
              final bool selected = index == selectedIndex;
              final containerColor = selected ? selectedColor : Colors.transparent;

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => indexNotifier.value = index,
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
