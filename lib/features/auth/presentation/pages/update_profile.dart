import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../core/constants/routes_data.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/widgets/popUps/image_source.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/buttons/ev_button.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/buttons/txt_button.dart';
import '../../../../injection/injector.dart';

@RoutePage(name: updatePR)
class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});

  final ValueNotifier<String> imagePath = ValueNotifier<String>("");
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
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 40.pH, bottom: 60.pH),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text("Select Profile", style: x3lSemibold()),
                  ],
                ),
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
              GestureDetector(
                onTap: () => imageSource(
                  context,
                  onImagePicked: (path) {
                    errorNtf.value = "";
                    imagePath.value = path;
                  },
                ),
                child: ValueListenableBuilder(
                  valueListenable: imagePath,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return ImageBuilder(
                        height: sCon.wP(.5),
                        width: sCon.wP(.5),
                        circular: true,
                        fit: BoxFit.cover,
                        imageProvider: const AssetImage("assets/images/user.png"),
                      );
                    }

                    return ImageBuilder(
                      height: sCon.wP(.5),
                      width: sCon.wP(.5),
                      circular: true,
                      fit: BoxFit.cover,
                      imageProvider: FileImage(File(value)),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.pH, bottom: 20.pH),
                child: EvButton(
                  onTap: () async {
                    if (imagePath.value.isEmpty) return errorNtf.value = "Select an image";

                    errorNtf.value = "";
                    final dState = await authCubit.updateProfile(imagePath.value);
                    if (dState is! SuccessState) errorNtf.value = dState.error!.message;
                  },
                  text: "Update",
                  color: kPrimary,
                  foregroundColor: kWhite,
                  expandWidth: true,
                  showLoading: true,
                ),
              ),
              TButton(
                onPressed: () => pushName(dashboardP),
                text: "Skip",
                compressSize: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
