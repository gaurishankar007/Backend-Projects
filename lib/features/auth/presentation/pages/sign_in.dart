import '../../../../core/resources/data_state.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../../../injection/injector.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/widgets/buttons/ev_button.dart';
import '../../../../core/widgets/cus_text_form.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/widgets/buttons/txt_button.dart';

@RoutePage(name: signInR)
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailCtr = BehaviorSubject<String>();
  final passwordCtr = BehaviorSubject<String>();

  final emailBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  final passwordBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
  );

  final ValueNotifier<String> errorNtf = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sHPad),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.pH, bottom: 25.pH),
                child: Text("Sign in with your email", style: x3lSemibold()),
              ),
              ValueListenableBuilder(
                valueListenable: errorNtf,
                builder: (context, value, child) {
                  if (value.isEmpty) return const SizedBox();

                  return Container(
                    margin: EdgeInsets.only(top: 5.pH, bottom: 30.pH),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: mdRegular(kError),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: emailCtr.stream,
                builder: (context, snapshot) {
                  return CusTextForm(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => emailCtr.sink.add(value ?? ""),
                    inputDecoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: emailBorder,
                      focusedBorder: emailBorder,
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              StreamBuilder<String>(
                stream: passwordCtr.stream,
                builder: (context, snapshot) {
                  return CusTextForm(
                    onChanged: (value) => passwordCtr.sink.add(value ?? ""),
                    obscureText: true,
                    inputDecoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: passwordBorder,
                      focusedBorder: passwordBorder,
                    ),
                  );
                },
              ),
              SizedBox(height: 50.pH),
              StreamBuilder(
                stream: Rx.combineLatest2(
                  emailCtr,
                  passwordCtr,
                  (a, b) => true,
                ),
                builder: (context, snapshot) {
                  String? email = emailCtr.stream.valueOrNull;
                  String? password = passwordCtr.stream.valueOrNull;
                  bool disabled = (email ?? "").isEmpty || (password ?? "").isEmpty;

                  return EvButton(
                    onTap: () async {
                      errorNtf.value = "";
                      final param = SignInPrm(email: email!, password: password!);
                      final dState = await authCubit.signIn(param);
                      if (dState is! SuccessState) errorNtf.value = dState.error!.message;
                    },
                    text: "Sign In",
                    expandWidth: true,
                    showLoading: true,
                    disabled: disabled,
                  );
                },
              ),
              const SizedBox(height: 10),
              EvButton(
                onTap: () => pushName(signUpP),
                expandWidth: true,
                text: "Create new account",
              ),
              SizedBox(height: 45.pH),
              TButton(
                onPressed: () {},
                text: "Forget Password?",
                textStyle: smMedium(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
