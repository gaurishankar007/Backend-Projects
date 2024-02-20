import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/utils/navigator.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form.dart';
import '../../../../injection/injector.dart';
import '../../injection/auth_injector.dart';
import '../widgets/error_text_notifier.dart';

@RoutePage(name: kSignUpRoute)
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameStreamController = BehaviorSubject<String>();
  final emailStreamController = BehaviorSubject<String>();
  final passwordStreamController = BehaviorSubject<String>();
  final confirmPStreamController = BehaviorSubject<String>();

  final ValueNotifier<String> errorNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.pHeight, bottom: 60.pHeight),
                child: Text("Welcome to chat app", style: x3LargeSemibold()),
              ),
              ErrorTextNotifier(errorNotifier: errorNotifier),
              SizedBox(height: 30.pHeight),
              CustomTextForm(
                onChanged: (value) => nameStreamController.sink.add(value ?? ""),
                inputDecoration: const InputDecoration(hintText: "Name"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.pHeight),
                child: CustomTextForm(
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
                margin: EdgeInsets.only(top: 20.pHeight),
                child: CustomTextForm(
                  onChanged: (value) => confirmPStreamController.sink.add(value ?? ""),
                  obscureText: true,
                  inputDecoration: const InputDecoration(hintText: "Confirm Password"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.pHeight),
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
          ),
        ),
      ),
    );
  }

  signUp({required String name, email, password, confirmP}) async {
    if (password != confirmP) {
      return errorNotifier.value = "Password did not matched with confirm password";
    }

    errorNotifier.value = "";
    final parameter = SignUpParameter(name: name, email: email, password: password);
    final dataState = await signUpUC.call(parameter);
    if (dataState is DataSuccessSate) {
      appData.setUserData = dataState.data!;
      return pushName(kUpdateProfilePath);
    }

    errorNotifier.value = dataState.error!.message;
  }
}
