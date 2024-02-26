import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/text_styles.dart';

class ErrorTextNotifier extends StatelessWidget {
  final ValueNotifier<String> errorNotifier;
  const ErrorTextNotifier({super.key, required this.errorNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: errorNotifier,
      builder: (context, value, child) {
        if (value.isEmpty) return const SizedBox();

        return Text(
          value,
          textAlign: TextAlign.center,
          style: mediumRegular(kError),
        );
      },
    );
  }
}
