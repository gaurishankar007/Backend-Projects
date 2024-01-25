import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/constants/page_transitions.dart';
import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/pick_image.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../injection/injector.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/ev_button.dart';
import '../../../../core/widgets/cus_text_form.dart';
import '../../../../core/widgets/txt_button.dart';

@RoutePage(name: signUpR)
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final pageController = PageController();
  final nameCtr = BehaviorSubject<String>();
  final emailCtr = BehaviorSubject<String>();
  final passwordCtr = BehaviorSubject<String>();
  final confirmPCtr = BehaviorSubject<String>();

  ImageProvider imageProvider = const AssetImage("assets/images/user.png");

  void nextPage() => pageController.nextPage(duration: ptDuration, curve: ptCurve);
  void previousPage() => pageController.previousPage(duration: ptDuration, curve: ptCurve);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (pageController.page != 0) return previousPage();

        Navigator.pop(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sHPad),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40.pH, bottom: 60.pH),
                      child: Text("Welcome to chat app", style: x3lSemibold()),
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
                            onTap: () {
                              nextPage();
                            },
                            expandWidth: true,
                            disabled: disabled,
                            text: "Sign Up",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sHPad),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 40.pH, bottom: 60.pH),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            child: IconButton(
                              onPressed: () => popPage(),
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Text("Select Profile", style: x3lSemibold()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String? imagePath = await pickImage(ImageSource.gallery);
                        if (imagePath == null) return;

                        imageProvider = FileImage(File(imagePath));
                        setState(() {});
                      },
                      child: ImageBuilder(
                        height: sCon.wP(.4),
                        width: sCon.wP(.4),
                        circular: true,
                        fit: BoxFit.cover,
                        imageProvider: imageProvider,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50.pH, bottom: 20.pH),
                      child: EvButton(
                        onTap: () {},
                        text: "Update",
                        color: kPrimary,
                        textColor: kWhite,
                        expandWidth: true,
                      ),
                    ),
                    TButton(
                      onPressed: () => popToSignIn(),
                      text: "Skip",
                      compressSize: false,
                    ),
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
