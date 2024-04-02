import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/constants/api_paths.dart';
import '../../core/services/user_service.dart';
import '../image_builder.dart';

class UserCircularImage extends StatelessWidget {
  final double diameter;
  const UserCircularImage({super.key, required this.diameter});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I<UserService>().userData.user;
    return ImageBuilder.circular(
      diameter: diameter,
      imageUrl: "$profileUrl/${user.profile}",
    );
  }
}
