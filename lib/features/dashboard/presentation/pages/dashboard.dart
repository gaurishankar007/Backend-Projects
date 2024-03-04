import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../injection/injector.dart';
import '../../../../widgets/buttons/custom_icon_button.dart';
import '../../../chat/presentation/pages/chats.dart';
import '../inheritedWidget/inherited_drawer_key.dart';
import 'drawer_content.dart';

@RoutePage(name: kDashboardRoute)
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final slidingDrawerKey = GlobalKey<SlidingDrawerState>();
  final drawerSettings = SlidingDrawerSettings(
    drawerWidth: appData.isTablet ? 50.wPercentage : 90.wPercentage,
    animationDuration: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    return InheritedDrawerKey(
      drawerKey: slidingDrawerKey,
      child: SlidingDrawer(
        key: slidingDrawerKey,
        settings: drawerSettings,
        drawerBuilder: (_) => DrawerContent(),
        contentBuilder: (_) => Scaffold(
          appBar: AppBar(
            leading: CustomIconButton(
              onPressed: () => slidingDrawerKey.open(),
              disableSplash: true,
              icon: Icon(Icons.menu_rounded, color: kPrimary, size: appBarIconSize),
            ),
            automaticallyImplyLeading: false,
          ),
          body: const Chats(),
        ),
      ),
    );
  }
}
