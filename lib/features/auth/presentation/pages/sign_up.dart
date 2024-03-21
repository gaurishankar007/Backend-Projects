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
import '../../../../widgets/custom_text_form.dart';
import '../../domain/forms/sign_up_form.dart';
import '../../domain/useCases/sign_up_uc.dart';
import '../widgets/error_text_notifier.dart';

@RoutePage(name: kSignUpRoute)
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameStreamController = BehaviorSubject<String>();
  final emailStreamController = BehaviorSubject<String>();
  final passwordStreamController = BehaviorSubject<String>();
  final confirmPStreamController = BehaviorSubject<String>();

  final ValueNotifier<String> errorNotifier = ValueNotifier<String>("");
  final String confirmPasswordError = "Password did not matched with confirm password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.propHeight, bottom: 60.propHeight),
              child: Text("Welcome to chat app", style: x3LargeSemibold()),
            ),
            ErrorTextNotifier(errorNotifier: errorNotifier),
            SizedBox(height: 30.propHeight),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: screen.dynamicHorizontalPadding),
              children: [
                CustomTextForm(
                  onChanged: (value) => nameStreamController.sink.add(value ?? ""),
                  inputDecoration: const InputDecoration(hintText: "Name"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.propHeight),
                  child: CustomTextForm(
                    textFormKey: const ValueKey("EmailHintText"),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => emailStreamController.sink.add(value ?? ""),
                    inputDecoration: const InputDecoration(hintText: "Email"),
                  ),
                ),
                CustomTextForm(
                  onChanged: (value) => passwordStreamController.sink.add(value ?? ""),
                  obscureText: true,
                  inputDecoration: const InputDecoration(hintText: "Password"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.propHeight),
                  child: CustomTextForm(
                    onChanged: (value) => confirmPStreamController.sink.add(value ?? ""),
                    obscureText: true,
                    inputDecoration: const InputDecoration(hintText: "Confirm Password"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.propHeight),
                  child: StreamBuilder(
                    stream: Rx.combineLatest4(
                      nameStreamController,
                      emailStreamController,
                      passwordStreamController,
                      confirmPStreamController,
                      (a, b, c, d) => true,
                    ),
                    builder: (context, snapshot) {
                      String? name = nameStreamController.stream.valueOrNull;
                      String? email = emailStreamController.stream.valueOrNull;
                      String? password = passwordStreamController.stream.valueOrNull;
                      String? confirmPassword = confirmPStreamController.stream.valueOrNull;

                      bool disabled = (name ?? "").isEmpty ||
                          (email ?? "").isEmpty ||
                          (password ?? "").isEmpty ||
                          (confirmPassword ?? "").isEmpty;

                      return CustomElevatedButton(
                        onTap: () => signUp(
                          name: name!,
                          email: email!,
                          password: password!,
                          confirmP: confirmPassword!,
                        ),
                        text: "Sign Up",
                        expandWidth: true,
                        disabled: disabled,
                        showLoading: true,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  signUp({required String name, email, password, confirmP}) async {
    if (password != confirmP) return errorNotifier.value = confirmPasswordError;

    errorNotifier.value = "";
    final parameter = SignUpForm(name: name, email: email, password: password);
    final dataState = await  getIt<SignUpUseCase>().call(parameter);
    if (dataState is DataSuccess) {
      userService.userData = dataState.data!;
      return pushName(kUpdateProfilePath);
    }

    errorNotifier.value = dataState.error!.message;
  }
}
