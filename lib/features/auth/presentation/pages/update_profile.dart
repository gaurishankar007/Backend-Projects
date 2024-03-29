import 'dart:io';

import 'package:auto_route/auto_route.dart';
import '../cubit/updateProfile/update_profile_cubit.dart';
import '../../../../injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../widgets/image_builder.dart';
import '../../../../widgets/modalSheets/image_picker_bottom_sheet.dart';
import '../widgets/error_text.dart';
import '../widgets/updateProfile/update_profile_actions.dart';

@RoutePage(name: UPDATE_PROFILE_ROUTE)
class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<UpdateProfileCubit>(),
          child: Builder(builder: (builderContext) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.propHeight, bottom: 20.propHeight),
                  child: Text("Select Profile", style: x3LargeSemibold()),
                ),
                BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  buildWhen: (previous, current) => previous.error != current.error,
                  builder: (context, state) => ErrorText(error: state.error),
                ),
                BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  buildWhen: (previous, current) => previous.imagePath != current.imagePath,
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => imagePickerBottomSheet(
                        context,
                        onImagePicked: (path) =>
                            builderContext.read<UpdateProfileCubit>().selectImage(path),
                      ),
                      child: ImageBuilder.circular(
                        diameter: 50.wPercentage,
                        imageProvider: imageProvider(state.imagePath),
                      ),
                    );
                  },
                ),
                const UpdateProfileActions(),
              ],
            );
          }),
        ),
      ),
    );
  }

  ImageProvider<Object> imageProvider(String imagePath) {
    if (imagePath.isEmpty) return AssetImage(userDefaultImage);
    return FileImage(File(imagePath));
  }
}
