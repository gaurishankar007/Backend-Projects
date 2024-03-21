import 'package:flutter/material.dart';

import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../../../../widgets/user/user_image.dart';
import '../../../../widgets/user/user_name.dart';
import '../widgets/setting_navigators.dart';
import '../widgets/setting_scaffold.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: "Setting",
      showLeading: false,
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
    );
  }
}
