import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/user_service.dart';
import '../../core/utils/text_styles.dart';

class UserName extends StatelessWidget {
  final TextStyle? textStyle;
  const UserName({super.key, this.textStyle});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I<UserService>().userData.user;
    return Text(user.name, style: textStyle ?? largeMedium());
  }
}
