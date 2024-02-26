import 'package:auto_route/auto_route.dart';
import 'package:chat/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_drawer/flutter_sliding_drawer.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../widgets/buttons/custom_icon_button.dart';
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
    drawerWidth: 90.wPercentage,
    barrierColor: null,
    animationDuration: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    return SlidingDrawer(
      key: slidingDrawerKey,
      settings: drawerSettings,
      drawerBuilder: (context) {
        return DrawerContent(drawerKey: slidingDrawerKey);
      },
      contentBuilder: (context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => slidingDrawerKey.open(),
            icon: Icon(Icons.menu_rounded, color: kPrimary, size: navigatorIconSize),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.maxFinite,
              ),
              Text("Dashboard"),
            ],
          ),
        ),
      ),
    );
  }
}
