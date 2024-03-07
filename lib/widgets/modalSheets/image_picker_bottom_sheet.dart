import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/constant.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/utils/image_picker.dart';
import '../buttons/custom_elevated_button.dart';

imagePickerBottomSheet(BuildContext context, {required Function(String path) onImagePicked}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: black.withOpacity(.1),
    builder: (modalSheetContext) {
      final Color popUpColor = context.surfaceColor(light: f5f5f5, dark: const Color(0XFF222222));

      return Container(
        padding: EdgeInsets.all(padding10),
        decoration: BoxDecoration(
          color: popUpColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(border15),
            topRight: Radius.circular(border15),
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
