import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/services/network_service.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/image_builder.dart';
import '../../../../widgets/modalSheets/image_picker_bottom_sheet.dart';
import '../../domain/useCases/save_user_data_uc.dart';
import '../../domain/useCases/update_profile_uc.dart';
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
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 40.propHeight, bottom: 60.propHeight),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text("Select Profile", style: x3LargeSemibold()),
                ],
              ),
            ),
            ErrorTextNotifier(errorNotifier: errorNotifier),
            SizedBox(height: 30.propHeight),
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
              margin: EdgeInsets.only(top: 50.propHeight, bottom: 20.propHeight),
              child: CustomElevatedButton(
                onTap: () async {
                  if (imagePathNotifier.value.isEmpty) {
                    return errorNotifier.value = "Select an image";
                  }

                  errorNotifier.value = "";
                  String imagePath = imagePathNotifier.value;
                  DioFormData formData = DioFormData.fromMap({
                    "profile": await DioMultiPartFile.fromFile(
                      imagePath,
                      filename: imagePath.split("/").last,
                      contentType: HttpMediaType("image", "jpg"),
                    ),
                  });
                  final dataState = await getIt<UpdateProfileUseCase>().call(formData);

                  if (dataState is DataSuccess) {
                    userService.userData = userService.userData.copyWith(user: dataState.data!);
                    getIt<SaveUserDataUseCase>().call(userService.userData);
                    return replaceToDashboard();
                  }

                  errorNotifier.value = dataState.error!.message;
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
        ),
      ),
    );
  }
}
