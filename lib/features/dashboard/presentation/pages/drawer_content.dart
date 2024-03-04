import 'package:chat/features/dashboard/presentation/widgets/drawer_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../injection/injector.dart';
import '../../data/models/drawer_navigation_entity.dart';
import '../widgets/drawer_logout_button.dart';
import '../widgets/drawer_navigation_item.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key});

  final List<DrawerNavigationModel> navigationItems = [
    const DrawerNavigationModel(name: "Chat", iconData: Icons.chat_bubble_rounded),
    const DrawerNavigationModel(name: "Message requests", iconData: Icons.chat_rounded),
    const DrawerNavigationModel(name: "Hidden", iconData: Icons.visibility_off_rounded),
  ];
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final Color drawerColor = themeCubit.surfaceColor(light: kDrawerLight, dark: kDrawerDark);
    final Color selectedColor =
        themeCubit.surfaceColor(light: kButtonContainerLight, dark: kButtonContainerDark);

    return Scaffold(
      backgroundColor: drawerColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, kToolbarHeight),
        child: DrawerAppBar(),
      ),
      body: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, value, child) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
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
          }),
      floatingActionButton: const DrawerLogoutButton(),
    );
  }
}
