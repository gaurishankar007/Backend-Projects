import 'package:auto_route/auto_route.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../injection/injector.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/buttons/ev_button.dart';

@RoutePage(name: dashboardR)
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: EvButton(
            onTap: () => authCubit.signOut(),
            text: "Sign Out",
            color: kPrimary,
            foregroundColor: kWhite,
          ),
        ),
      ),
    );
  }
}
