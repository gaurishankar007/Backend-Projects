import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../injection/injector.dart';
import '../../constants/colors.dart';
import '../../utils/pick_image.dart';
import '../buttons/ev_button.dart';

imageSource(BuildContext ctx, {required Function(String path) onImagePicked}) {
  showModalBottomSheet(
    context: ctx,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeCubit.tColor(light: kPopUpL, dark: kPopUpD),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            EvButton(
              onTap: () async {
                Navigator.pop(_);
                String? imagePath = await pickImage(ImageSource.camera);
                if (imagePath == null) return;

                onImagePicked(imagePath);
              },
              text: "Camera",
              icon: Icons.camera_alt_rounded,
            ),
            EvButton(
              onTap: () async {
                Navigator.pop(_);
                String? imagePath = await pickImage(ImageSource.gallery);
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
