import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../cubit/signUp/sign_up_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.nameController != current.nameController,
      builder: (context, state) {
        return StreamBuilder(
          stream: Rx.combineLatest4(
            state.nameController,
            state.emailController,
            state.passwordController,
            state.confirmPasswordController,
            (a, b, c, d) => a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty,
          ),
          builder: (context, snapshot) {
            return CustomElevatedButton(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                bool succeed = await context.read<SignUpCubit>().sigUp();
                if (succeed) {
                  AppNavigator.pushName(UPDATE_PROFILE_PATH);
                  AppNavigator.removeLast();
                }
              },
              text: "Sign Up",
              expandWidth: true,
              showLoading: true,
              disabled: !(snapshot.data ?? false),
            );
          },
        );
      },
    );
  }
}
