import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../core/services/local_database.dart';
import '../../inheritedWidget/drawer_key_inherited_widget.dart';

class DrawerLogoutButton extends StatelessWidget {
  const DrawerLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerKey = DrawerKeyInheritedWidget.of(context).drawerKey;

    return FloatingActionButton(
      onPressed: () async {
        drawerKey.close();
        GetIt.I<LocalDatabase>().clearAll();
        AppNavigator.replaceToSignIn();
      },
      backgroundColor: primaryColor,
      elevation: 0,
      child: Icon(Icons.logout_rounded, color: white, size: appBarIconSize),
    );
  }
}
