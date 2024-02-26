import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../injection/injector.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/image_picker.dart';
import '../buttons/custom_elevated_button.dart';

imagePickerBottomSheet(BuildContext context, {required Function(String path) onImagePicked}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (modalSheetContext) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeCubit.onSurfaceColor(light: kPopUpLight, dark: kPopUpDark),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomElevatedButton(
              onTap: () async {
                Navigator.pop(modalSheetContext);
                String? imagePath = await imagePicker(ImageSource.camera);
                if (imagePath == null) return;

                onImagePicked(imagePath);
              },
              text: "Camera",
              icon: Icons.camera_alt_rounded,
            ),
            CustomElevatedButton(
              onTap: () async {
                Navigator.pop(modalSheetContext);
                String? imagePath = await imagePicker(ImageSource.gallery);
                if (imagePath == null) return;

                onImagePicked(imagePath);
              },
              text: "Gallery",
              icon: Icons.image_rounded,
            )
          ],
        ),
      );
    },
  );
}
