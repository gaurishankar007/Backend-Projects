import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/int_extension.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../cubit/signUp/sign_up_cubit.dart';
import '../widgets/error_text.dart';
import '../widgets/signUp/sign_up_button.dart';
import '../widgets/signUp/sign_up_form_container.dart';

@RoutePage(name: SIGN_UP_ROUTE)
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.propHeight, bottom: 20.propHeight),
                child: Text("Welcome to chat app", style: x3LargeSemibold()),
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) => previous.error != current.error,
                builder: (context, state) => ErrorText(error: state.error),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: screen.dynamicHorizontalPadding),
                  children: [
                    const SignUpFormContainer(),
                    SizedBox(height: 50.propHeight),
                    const SignUpButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
