import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/int_extension.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../cubit/signUp/sign_up_cubit.dart';

class SignUpFormContainer extends StatelessWidget {
  const SignUpFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.nameController != current.nameController,
      builder: (context, state) {
        final nameController = state.nameController;
        final emailController = state.emailController;
        final passwordController = state.passwordController;
        final confirmPasswordController = state.confirmPasswordController;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextForm(
              onChanged: (value) => nameController.sink.add(value ?? ""),
              inputDecoration: const InputDecoration(hintText: "Name"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.propHeight),
              child: CustomTextForm(
                textFormKey: const ValueKey("EmailHintText"),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => emailController.sink.add(value ?? ""),
                inputDecoration: const InputDecoration(hintText: "Email"),
              ),
            ),
            CustomTextForm(
              onChanged: (value) => passwordController.sink.add(value ?? ""),
              obscureText: true,
              inputDecoration: const InputDecoration(hintText: "Password"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.propHeight),
              child: CustomTextForm(
                onChanged: (value) => confirmPasswordController.sink.add(value ?? ""),
                obscureText: true,
                inputDecoration: const InputDecoration(hintText: "Confirm Password"),
              ),
            ),
          ],
        );
      },
    );
  }
}
