import '../../../../core/constants/colors.dart';
import '../../domain/parameters/sign_up_param.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/constants/padding.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/buttons/ev_button.dart';
import '../../../../core/widgets/cus_text_form.dart';
import '../../../../injection/injector.dart';

@RoutePage(name: signUpR)
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameCtr = BehaviorSubject<String>();
  final emailCtr = BehaviorSubject<String>();
  final passwordCtr = BehaviorSubject<String>();
  final confirmPCtr = BehaviorSubject<String>();

  final ValueNotifier<String> errorNtf = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sHPad),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.pH, bottom: 60.pH),
                child: Text("Welcome to chat app", style: x3lSemibold()),
              ),
              ValueListenableBuilder(
                valueListenable: errorNtf,
                builder: (context, value, child) {
                  if (value.isEmpty) return const SizedBox();

                  return Container(
                    margin: EdgeInsets.only(bottom: 30.pH),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: mdRegular(kError),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: nameCtr.stream,
                builder: (context, snapshot) {
                  return CusTextForm(
                    onChanged: (value) => nameCtr.sink.add(value ?? ""),
                    inputDecoration: const InputDecoration(hintText: "Name"),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.pH),
                child: StreamBuilder<String>(
                  stream: emailCtr.stream,
                  builder: (context, snapshot) {
                    return CusTextForm(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => emailCtr.sink.add(value ?? ""),
                      inputDecoration: const InputDecoration(hintText: "Email"),
                    );
                  },
                ),
              ),
              StreamBuilder<String>(
                stream: passwordCtr.stream,
                builder: (context, snapshot) {
                  return CusTextForm(
                    onChanged: (value) => passwordCtr.sink.add(value ?? ""),
                    obscureText: true,
                    inputDecoration: const InputDecoration(hintText: "Password"),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20.pH),
                child: StreamBuilder<String>(
                  stream: confirmPCtr.stream,
                  builder: (context, snapshot) {
                    return CusTextForm(
                      onChanged: (value) => confirmPCtr.sink.add(value ?? ""),
                      obscureText: true,
                      inputDecoration: const InputDecoration(hintText: "Confirm Password"),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.pH),
                child: StreamBuilder(
                  stream: Rx.combineLatest4(
                    nameCtr,
                    emailCtr,
                    passwordCtr,
                    confirmPCtr,
                    (a, b, c, d) => true,
                  ),
                  builder: (context, snapshot) {
                    String? name = nameCtr.stream.valueOrNull;
                    String? email = emailCtr.stream.valueOrNull;
                    String? password = passwordCtr.stream.valueOrNull;
                    String? confirmP = confirmPCtr.stream.valueOrNull;

                    bool disabled = (name ?? "").isEmpty ||
                        (email ?? "").isEmpty ||
                        (password ?? "").isEmpty ||
                        (confirmP ?? "").isEmpty;

                    return EvButton(
                      onTap: () => signUp(
                        name: name!,
                        email: email!,
                        password: password!,
                        confirmP: confirmP!,
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
      return errorNtf.value = "Password did not matched with confirm password";
    }

    errorNtf.value = "";
    final param = SignUpPrm(name: name, email: email, password: password);
    final dState = await authCubit.signUp(param);
    if (dState is! SuccessState) errorNtf.value = dState.error!.message;
  }
}
