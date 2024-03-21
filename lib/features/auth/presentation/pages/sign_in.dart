import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injector/injector.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/buttons/custom_text_button.dart';
import '../../../../widgets/custom_text_form.dart';
import '../../domain/forms/sign_in_form.dart';
import '../../domain/useCases/sign_in_uc.dart';
import '../widgets/error_text_notifier.dart';

@RoutePage(name: kSignInRoute)
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailStreamController = BehaviorSubject<String>();
  final passwordStreamController = BehaviorSubject<String>();

  final emailTextFormBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  final passwordTextFormBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
  );

  final ValueNotifier<String> errorNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.propHeight, bottom: 25.propHeight),
              child: Text("Sign in with your email", style: x3LargeSemibold()),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.propHeight, bottom: 30.propHeight),
              child: ErrorTextNotifier(errorNotifier: errorNotifier),
            ),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: screen.dynamicHorizontalPadding),
              children: [
                CustomTextForm(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => emailStreamController.sink.add(value ?? ""),
                  inputDecoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: emailTextFormBorder,
                    focusedBorder: emailTextFormBorder,
                  ),
                ),
                const SizedBox(height: 2),
                CustomTextForm(
                  onChanged: (value) => passwordStreamController.sink.add(value ?? ""),
                  obscureText: true,
                  inputDecoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: passwordTextFormBorder,
                    focusedBorder: passwordTextFormBorder,
                  ),
                ),
                SizedBox(height: 50.propHeight),
                StreamBuilder(
                  stream: Rx.combineLatest2(
                    emailStreamController,
                    passwordStreamController,
                    (a, b) => true,
                  ),
                  builder: (context, snapshot) {
                    String? email = emailStreamController.stream.valueOrNull;
                    String? password = passwordStreamController.stream.valueOrNull;
                    bool disabled = (email ?? "").isEmpty || (password ?? "").isEmpty;

                    return CustomElevatedButton(
                      onTap: () async {
                        errorNotifier.value = "";
                        final parameter = SignInForm(email: email!, password: password!);
                        final dataState = await getIt<SignInUseCase>().call(parameter);

                        if (dataState is DataSuccess) {
                          userService.userData = dataState.data!;
                          return replaceToDashboard();
                        }

                        errorNotifier.value = dataState.error!.message;
                      },
                      text: "Sign In",
                      expandWidth: true,
                      showLoading: true,
                      disabled: disabled,
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  onTap: () => pushName(kSignUpPath),
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
            ),
          ],
        ),
      ),
    );
  }
}
