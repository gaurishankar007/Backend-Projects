import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/open_db.dart';
import '../inheritedWidget/inherited_drawer_key.dart';

class DrawerLogoutButton extends StatelessWidget {
  const DrawerLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerKey = InheritedDrawerKey.of(context).drawerKey;

    return FloatingActionButton.small(
      onPressed: () async {
        drawerKey.close();
        final isar = await openIsarDB();
        isar.writeTxnSync(() => isar.clearSync());
        replaceToSignIn();
      },
      backgroundColor: kPrimary,
      elevation: 0,
      child: Icon(Icons.logout_rounded, color: kWhite, size: 18),
    );
  }
}
