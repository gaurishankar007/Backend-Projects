import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../../widgets/buttons/custom_text_button.dart';
import '../../cubit/signIn/sign_in_cubit.dart';

class SignInAction extends StatelessWidget {
  const SignInAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<SignInCubit, SignInState>(
          buildWhen: (previous, current) => previous.emailController != current.emailController,
          builder: (context, state) {
            return StreamBuilder(
              stream: Rx.combineLatest2(
                state.emailController,
                state.passwordController,

                /// If the controllers are not empty then, snapshot data will be true
                (a, b) => a.isNotEmpty & b.isNotEmpty,
              ),
              builder: (context, snapshot) {
                return CustomElevatedButton(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    bool succeed = await context.read<SignInCubit>().sigIn();
                    if (succeed) replaceToDashboard();
                  },
                  text: "Sign In",
                  expandWidth: true,
                  showLoading: true,
                  disabled: !(snapshot.data ?? false),
                );
              },
            );
          },
        ),
        const SizedBox(height: 10),
        CustomElevatedButton(
          onTap: () => pushName(SIGN_UP_PATH),
          expandWidth: true,
          text: "Create new account",
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 45.propHeight),
          child: CustomTextButton(
            onPressed: () {},
            text: "Forget Password?",
            textStyle: smallMedium(),
          ),
        ),
      ],
    );
  }
}
