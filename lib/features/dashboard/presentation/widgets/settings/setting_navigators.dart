import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../cubit/cubit/setting_cubit.dart';
import 'setting_navigation_item.dart';

class SettingNavigators extends StatelessWidget {
  const SettingNavigators({super.key});

  @override
  Widget build(BuildContext context) {
    /// Color of the container containing setting navigation items
    final containerColor = context.surfaceColor(
      light: Colors.white,
      dark: const Color(0XFF333333),
    );

    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final settingItems = state.navigationModels;
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30.propHeight),
          padding: EdgeInsets.all(padding10),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(border10),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: settingItems.length,
            separatorBuilder: (context, index) => Divider(indent: 10.wPercentage),
            itemBuilder: (context, index) {
              final settingItem = settingItems[index];
              return SettingNavigationItem(settingItem: settingItem);
            },
          ),
        );
      },
    );
  }
}
