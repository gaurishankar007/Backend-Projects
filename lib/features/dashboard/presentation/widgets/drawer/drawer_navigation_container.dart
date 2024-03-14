import 'package:flutter/material.dart';

import '../../../../../core/extensions/int_extension.dart';
import '../../../../../injection/injector.dart';
import '../../../data/models/drawer_navigation_model.dart';
import 'drawer_navigation_item.dart';

class DrawerNavigationContainer extends StatefulWidget {
  const DrawerNavigationContainer({super.key});

  @override
  State<DrawerNavigationContainer> createState() => _DrawerNavigationContainerState();
}

class _DrawerNavigationContainerState extends State<DrawerNavigationContainer> {
  final List<NavigationDataModel> navigationItems = [
    const NavigationDataModel(id: 1, name: "Chats", iconData: Icons.chat_bubble_rounded),
    const NavigationDataModel(id: 2, name: "Message requests", iconData: Icons.chat_rounded),
    const NavigationDataModel(id: 3, name: "Hidden", iconData: Icons.visibility_off_rounded),
  ];
  final ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                indexNotifier.value = index;
              },
              child: DrawerNavigationItem(
                selected: index == selectedIndex,
                navigationItem: navigationItems[index],
              ),
            );
          },
        );
      },
    );
  }
}
