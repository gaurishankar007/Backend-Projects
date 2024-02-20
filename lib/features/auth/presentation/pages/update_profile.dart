import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../widgets/popUps/image_picker_bottom_sheet.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/image_builder.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../injection/injector.dart';
import '../../injection/auth_injector.dart';
import '../widgets/error_text_notifier.dart';

@RoutePage(name: kUpdateProfileRoute)
class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});

  final ValueNotifier<String> imagePathNotifier = ValueNotifier<String>("");
  final ValueNotifier<String> errorNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 40.pHeight, bottom: 60.pHeight),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text("Select Profile", style: x3LargeSemibold()),
                  ],
                ),
              ),
              ErrorTextNotifier(errorNotifier: errorNotifier),
              SizedBox(height: 30.pHeight),
              GestureDetector(
                onTap: () => imagePickerBottomSheet(
                  context,
                  onImagePicked: (path) {
                    errorNotifier.value = "";
                    imagePathNotifier.value = path;
                  },
                ),
                child: ValueListenableBuilder(
                  valueListenable: imagePathNotifier,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return ImageBuilder(
                        height: 50.wPercentage,
                        width: 50.wPercentage,
                        circular: true,
                        fit: BoxFit.cover,
                        imageProvider: const AssetImage("assets/images/user.png"),
                      );
                    }

                    return ImageBuilder(
                      height: 50.wPercentage,
                      width: 50.wPercentage,
                      circular: true,
                      fit: BoxFit.cover,
                      imageProvider: FileImage(File(value)),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.pHeight, bottom: 20.pHeight),
                child: CustomElevatedButton(
                  onTap: () async {
                    if (imagePathNotifier.value.isEmpty) {
                      return errorNotifier.value = "Select an image";
                    }

                    errorNotifier.value = "";
                    final dataState = await updateProfileUseCase.call(imagePathNotifier.value);

                    if (dataState is DataSuccessSate) {
                      appData.setUserData = appData.userData.copyWith(user: dataState.data!);
                      saveUserDataUseCase.call(appData.userData);
                      return replaceToDashboard();
                    }

                    errorNotifier.value = dataState.error!.message;
                  },
                  text: "Update",
                  color: primaryColor,
                  foregroundColor: whiteColor,
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
          ),
        ),
      ),
    );
  }
}
