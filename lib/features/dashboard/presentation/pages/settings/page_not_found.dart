import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../widgets/settings/setting_scaffold.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScaffold(
      appBarTitle: 'Page Not Found',
      body: Center(
        child: Text(
          'The page your looking for is not available.',
          style: largeMedium(errorColor),
        ),
      ),
    );
  }
}
