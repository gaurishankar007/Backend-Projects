import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../../../../widgets/image_builder.dart';
import '../../../../widgets/modalSheets/image_picker_bottom_sheet.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/error_text.dart';
import '../widgets/updateProfile/update_profile_actions.dart';

@RoutePage(name: kUpdateProfileRoute)
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final ValueNotifier<String> imagePathNotifier = ValueNotifier<String>("");

  @override
  void dispose() {
    authCubit.removeUpdateProfileError();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.propHeight, bottom: 20.propHeight),
              child: Text("Select Profile", style: x3LargeSemibold()),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) =>
                  previous.updateProfileError != current.updateProfileError,
              builder: (context, state) => ErrorText(error: state.updateProfileError),
            ),
            GestureDetector(
              onTap: () => imagePickerBottomSheet(
                context,
                onImagePicked: (path) => imagePathNotifier.value = path,
              ),
              child: ValueListenableBuilder(
                valueListenable: imagePathNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return ImageBuilder.circular(
                      diameter: 50.wPercentage,
                      imageProvider: AssetImage(userDefaultImage),
                    );
                  }

                  return ImageBuilder.circular(
                    diameter: 50.wPercentage,
                    imageProvider: FileImage(File(value)),
                  );
                },
              ),
            ),
            UpdateProfileActions(notifier: imagePathNotifier)
          ],
        ),
      ),
    );
  }
}
