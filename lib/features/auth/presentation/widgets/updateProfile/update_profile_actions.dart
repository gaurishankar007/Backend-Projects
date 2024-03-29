import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../injector/injector.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../../widgets/buttons/custom_text_button.dart';
import '../../cubit/updateProfile/update_profile_cubit.dart';

class UpdateProfileActions extends StatelessWidget {
  const UpdateProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: screen.dynamicHorizontalPadding,
            left: screen.dynamicHorizontalPadding,
            top: 50.propHeight,
            bottom: 20.propHeight,
          ),
          child: CustomElevatedButton(
            onTap: () async {
              bool succeed = await context.read<UpdateProfileCubit>().updateProfile();
              if (succeed) AppNavigator.replaceToDashboard();
            },
            text: "Update",
            color: primaryColor,
            foregroundColor: white,
            expandWidth: true,
            showLoading: true,
          ),
        ),
        CustomTextButton(
          onPressed: () => AppNavigator.pushName(DASHBOARD_PATH),
          text: "Skip",
          compressSize: false,
        ),
      ],
    );
  }
}
