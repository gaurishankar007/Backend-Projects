import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/routes_data.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../injection/injector.dart';
import '../../../../../widgets/preferred_size_app_bar.dart';
import '../../../../../widgets/user/user_image.dart';
import '../../../../../widgets/user/user_name.dart';
import '../../widgets/settings/setting_app_bar.dart';
import '../../widgets/settings/setting_navigators.dart';

@RoutePage(name: kSettingRoute)
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final Color popUpColor = context.surfaceColor(light: f5f5f5, dark: const Color(0XFF222222));

    return BlocProvider(
      create: (context) => settingCubit,
      child: Scaffold(
        backgroundColor: popUpColor,
        appBar: const PreferredSizeAppBar(
          appBar: SettingAppBar(title: "Setting", showLeading: false),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.symmetric(horizontal: screen.horizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: UserCircularImage(diameter: 25.wPercentage),
              ),
              UserName(textStyle: x2LargeBold()),
              const SettingNavigators(),
            ],
          ),
        ),
      ),
    );
  }
}
