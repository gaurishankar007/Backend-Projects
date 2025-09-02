import 'package:auto_route/auto_route.dart';
import '../../../../core/utils/screen.dart';
import '../cubit/signIn/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/int_extension.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../widgets/error_text.dart';
import '../widgets/signIn/sign_in_actions.dart';
import '../widgets/signIn/sign_in_form_container.dart';

@RoutePage(name: SIGN_IN_ROUTE)
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<SignInCubit>(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.propHeight, bottom: 20.propHeight),
                child: Text("Sign in with your email", style: x3LargeSemibold()),
              ),
              BlocBuilder<SignInCubit, SignInState>(
                buildWhen: (previous, current) => previous.error != current.error,
                builder: (context, state) => ErrorText(error: state.error),
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: Screen.dynamicHorizontalPadding),
                children: [
                  const SignInFormContainer(),
                  SizedBox(height: 50.propHeight),
                  const SignInAction(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
