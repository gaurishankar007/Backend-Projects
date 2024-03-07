import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/routes_data.dart';
import '../../../../../injection/injector.dart';

@RoutePage(name: kSettingDashboardRoute)
class SettingDashboard extends StatefulWidget {
  const SettingDashboard({super.key});

  @override
  State<SettingDashboard> createState() => _SettingDashboardState();
}

class _SettingDashboardState extends State<SettingDashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingCubit,
      child: const AutoRouter(),
    );
  }
}
