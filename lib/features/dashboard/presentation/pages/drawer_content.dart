import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../injection/injector.dart';
import '../../../../widgets/buttons/custom_icon_button.dart';
import '../../../../widgets/image_builder.dart';
import '../../data/models/drawer_navigation_entity.dart';
import '../widgets/navigation_item.dart';

class DrawerContent extends StatefulWidget {
  final GlobalKey<SlidingDrawerState> drawerKey;
  const DrawerContent({super.key, required this.drawerKey});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  final user = appData.userData.user;
  final List<DrawerNavigationModel> navigationItems = [
    const DrawerNavigationModel(name: "Chat", iconData: Icons.chat_bubble_rounded),
    const DrawerNavigationModel(name: "Message requests", iconData: Icons.chat_rounded),
    const DrawerNavigationModel(name: "Hidden", iconData: Icons.visibility_off_rounded),
  ];
  final logoutNavigationItem =
      const DrawerNavigationModel(name: "Logout", iconData: Icons.logout_rounded);
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final drawerColor = themeCubit.surfaceColor(light: kDrawerLight, dark: kDrawerDark);
    final selectedColor =
        themeCubit.surfaceColor(light: kButtonContainerLight, dark: kButtonContainerDark);

    return Scaffold(
      backgroundColor: drawerColor,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: ImageBuilder(
            height: 40.pWConstraint(max: 45),
            width: 40.pWConstraint(max: 45),
            circular: true,
            imageUrl: "$profileUrl/${user.profile}",
          ),
        ),
        leadingWidth: horizontalPadding + 40.pWConstraint(max: 45),
        title: Text(user.name),
        titleSpacing: 10.pWConstraint(max: 15),
        actions: [
          CustomIconButton(
            onPressed: () {},
            disableSplash: true,
            icon: Icon(Icons.settings_rounded, color: kPrimary, size: navigatorIconSize),
          ),
          SizedBox(width: horizontalPadding)
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 15.propHeight,
        ),
        itemCount: navigationItems.length,
        separatorBuilder: (_, index) => SizedBox(height: 10.propHeight),
        itemBuilder: (context, index) {
          final navigationItem = navigationItems[index];

          return ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, value, child) {
              final bool selected = index == value;
              final containerColor = selected ? selectedColor : drawerColor;

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  selectedIndex.value = index;
                },
                child: DrawerNavigationItem(
                  navigationItem: navigationItem,
                  backgroundColor: containerColor,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.drawerKey.close();
          authCubit.signOut();
        },
        backgroundColor: kPrimary,
        elevation: 0,
        child: Icon(
          Icons.logout_rounded,
          color: kWhite,
          size: navigatorIconSize,
        ),
      ),
    );
  }
}
