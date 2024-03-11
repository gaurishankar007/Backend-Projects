import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../injection/injector.dart';
import '../../../chat/presentation/pages/chats.dart';
import '../inheritedWidget/drawer_key_inherited_widget.dart';
import 'drawer_content.dart';

@RoutePage(name: kDashboardRoute)
class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final slidingDrawerKey = GlobalKey<SlidingDrawerState>();
  final drawerSettings = SlidingDrawerSettings(
    drawerWidth: screen.dynamicDrawerWidth,
    animationDuration: pageTransitionDuration,
  );

  @override
  Widget build(BuildContext context) {
    return DrawerKeyInheritedWidget(
      drawerKey: slidingDrawerKey,
      child: SlidingDrawer(
        key: slidingDrawerKey,
        settings: drawerSettings,
        drawerBuilder: (_) => const DrawerContent(),
        contentBuilder: (_) => const Scaffold(
          body: Chats(),
        ),
      ),
    );
  }
}
