import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/custom_text_form.dart';
import '../../cubit/signIn/sign_in_cubit.dart';

class SignInFormContainer extends StatelessWidget {
  const SignInFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);
    const emailTextFormBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.only(topLeft: borderRadius, topRight: borderRadius),
    );
    const passwordTextFormBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.only(bottomLeft: borderRadius, bottomRight: borderRadius),
    );

    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.emailController != current.emailController,
      builder: (context, state) {
        final emailController = state.emailController;
        final passwordController = state.passwordController;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextForm(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => emailController.sink.add(value ?? ""),
              inputDecoration: const InputDecoration(
                hintText: "Email",
                enabledBorder: emailTextFormBorder,
                focusedBorder: emailTextFormBorder,
              ),
            ),
            const SizedBox(height: 2),
            CustomTextForm(
              onChanged: (value) => passwordController.sink.add(value ?? ""),
              obscureText: true,
              inputDecoration: const InputDecoration(
                hintText: "Password",
                enabledBorder: passwordTextFormBorder,
                focusedBorder: passwordTextFormBorder,
              ),
            ),
          ],
        );
      },
    );
  }
}
