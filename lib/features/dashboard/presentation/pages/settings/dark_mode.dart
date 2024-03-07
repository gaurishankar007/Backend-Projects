import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/routes_data.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../injection/injector.dart';
import '../../../../../widgets/preferred_size_app_bar.dart';
import '../../widgets/settings/setting_app_bar.dart';

@RoutePage(name: kDarkModeRoute)
class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    final Color popUpColor = context.surfaceColor(light: f5f5f5, dark: const Color(0XFF222222));
    return Scaffold(
      backgroundColor: popUpColor,
      appBar: const PreferredSizeAppBar(appBar: SettingAppBar(title: "Dark Mode")),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: screen.horizontalPadding),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
