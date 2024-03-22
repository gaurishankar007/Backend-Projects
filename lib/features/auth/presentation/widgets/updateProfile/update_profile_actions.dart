import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/services/network_service.dart';
import '../../../../../injector/injector.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../../widgets/buttons/custom_text_button.dart';

class UpdateProfileActions extends StatelessWidget {
  final ValueNotifier<String> notifier;
  const UpdateProfileActions({super.key, required this.notifier});

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
              String imagePath = notifier.value;
              if (imagePath.isEmpty) return authCubit.updateProfileError("Select a image");

              DioFormData formData = DioFormData.fromMap({
                "profile": await DioMultiPartFile.fromFile(
                  notifier.value,
                  filename: notifier.value.split("/").last,
                  contentType: HttpMediaType("image", "jpg"),
                ),
              });

              if (!context.mounted) return;
              await authCubit.updateProfile(formData);
            },
            text: "Update",
            color: primaryColor,
            foregroundColor: white,
            expandWidth: true,
            showLoading: true,
          ),
        ),
        CustomTextButton(
          onPressed: () => pushName(kDashboardPath),
          text: "Skip",
          compressSize: false,
        ),
      ],
    );
  }
}
