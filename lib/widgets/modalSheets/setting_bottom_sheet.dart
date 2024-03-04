import 'package:chat/core/constants/constant.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../features/dashboard/presentation/pages/settings.dart';

showSettingBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: kBlack.withOpacity(.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(border8)),
    scrollControlDisabledMaxHeightRatio: .9,
    useSafeArea: true,
    builder: (_) =>  Settings(),
  );
}
