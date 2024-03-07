import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/constant.dart';
import '../../features/dashboard/presentation/pages/settings/settings.dart';

showSettingBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: black.withOpacity(.1),
    scrollControlDisabledMaxHeightRatio: .9,
    useSafeArea: true,
    builder: (_) => ClipRRect(
      borderRadius: BorderRadius.circular(border10),
      child: const Settings(),
    ),
  );
}
