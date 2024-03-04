import 'package:chat/core/constants/colors.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/core/utils/navigator.dart';
import 'package:chat/core/utils/text_styles.dart';
import 'package:chat/injection/injector.dart';
import 'package:chat/widgets/glass_layer.dart';
import 'package:chat/widgets/image_builder.dart';
import 'package:flutter/material.dart';
import 'package:chat/core/constants/constant.dart';

import '../../../../core/constants/api_paths.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final user = appData.userData.user;
  final imageSize = 25.wPercentage;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = themeCubit.surfaceColor(light: kPopUpLight, dark: kPopUpDark);
    final Color surfaceColor = themeCubit.surfaceColor();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, kToolbarHeight),
        child: GlassLayer(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            height: kToolbarHeight,
            color: surfaceColor.withOpacity(.05),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Settings", style: largeSemibold()),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => popPage(),
                    child: Text("Done", style: largeSemibold()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            ImageBuilder(
              height: imageSize,
              width: imageSize,
              circular: true,
              imageUrl: "$profileUrl/${user.profile}",
            ),
            const SizedBox(height: 10, width: double.maxFinite),
            Text(user.name, style: x2LargeBold()),
          ],
        ),
      ),
    );
  }
}
