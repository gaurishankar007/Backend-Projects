import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/widgets/ev_button.dart';
import '../../../../core/widgets/cus_text_form.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/widgets/txt_button.dart';

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
              StreamBuilder<String>(
                stream: emailCtr.stream,
                builder: (context, snapshot) {
                  return CusTextForm(
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
                    onTap: () {},
                    expandWidth: true,
                    disabled: disabled,
                    text: "Sign In",
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
