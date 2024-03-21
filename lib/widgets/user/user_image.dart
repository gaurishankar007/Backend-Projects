import 'package:flutter/material.dart';

import '../../core/constants/api_paths.dart';
import '../../injector/injector.dart';
import '../image_builder.dart';

class UserCircularImage extends StatelessWidget {
  final double diameter;
  const UserCircularImage({super.key, required this.diameter});

  @override
  Widget build(BuildContext context) {
    final user = userService.userData.user;
    return ImageBuilder.circular(
      diameter: diameter,
      imageUrl: "$profileUrl/${user.profile}",
    );
  }
}
