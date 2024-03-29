import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../widgets/sliding_drawer.dart';
import '../../../chat/presentation/pages/chats.dart';
import '../inheritedWidget/drawer_key_inherited_widget.dart';
import '../widgets/dashboard_navigation.dart';
import 'drawer_content.dart';

@RoutePage(name: DASHBOARD_ROUTE)
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<SlidingDrawerState> drawerKey = GlobalKey<SlidingDrawerState>();

  @override
  Widget build(BuildContext context) {
    return DrawerKeyInheritedWidget(
      drawerKey: drawerKey,
      child: SlidingDrawerWidget(
        drawerKey: drawerKey,
        drawer: const DrawerContent(),
        content: const Scaffold(
          body: Chats(),
          bottomNavigationBar: DashboardNavigation(),
        ),
      ),
    );
  }
}
