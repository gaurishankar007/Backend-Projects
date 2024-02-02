import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exception_handler.dart';
import '../../../../core/utils/auth_header.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../injection/injector.dart';
import '../../data/models/userData/user_data_model.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../models/user/user_model.dart';

abstract class AuthRemoteSource {
  FDState<UserDataModel> signIn(SignInPrm param);
  FDState<UserDataModel> signUp(SignUpPrm param);
  FDState<UserModel> updateProfile(String imagePath);
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  @override
  FDState<UserDataModel> signIn(SignInPrm param) async {
    return await exceptionHandler(() async {
      final res = await dio.post(
        kSignInUrl,
        data: param.toJson,
        options: Options(
          validateStatus: (status) => status == 200 || status == 401,
        ),
      );

      bool status = res.data["status"];

      if (status) {
        UserDataModel userData = UserDataModel.fromJson(res.data["data"]);
        return SuccessState(data: userData);
      }

      return FailureState<UserDataModel>(
        error: DError(
          error: "Authentication error",
          message: res.data["error"],
          type: ErrorType.invalidUserCredential,
        ),
      );
    });
  }

  @override
  FDState<UserDataModel> signUp(SignUpPrm param) async {
    return await exceptionHandler(() async {
      final res = await dio.post(
        kSignUpUrl,
        data: param.toJson,
        options: Options(
          validateStatus: (status) => status == 200 || status == 400,
        ),
      );

      bool status = res.data["status"];

      if (status) {
        UserDataModel userData = UserDataModel.fromJson(res.data["data"]);
        return SuccessState(data: userData);
      }

      return FailureState<UserDataModel>(
        error: DError(
          error: "Registration error",
          message: res.data["error"],
          type: ErrorType.badRequest,
        ),
      );
    });
  }

  @override
  FDState<UserModel> updateProfile(String imagePath) async {
    return await exceptionHandler(() async {
      FormData data = FormData.fromMap({
        "profilePic": await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split("/").last,
          contentType: MediaType("image", "jpg"),
        ),
      });

      final res = await dio.put(
        kUpdateProfileUrl,
        data: data,
        options: Options(
          headers: reqHeaders(isFormData: true),
          validateStatus: (status) => status == 200 || status == 400,
        ),
      );

      bool status = res.data["status"];
      if (status) {
        UserModel user = UserModel.fromJson(res.data["data"]);
        return SuccessState(data: user);
      }

      return FailureState<UserModel>(
        error: DError(
          error: "Profile upload error",
          message: res.data["error"],
        ),
      );
    });
  }
}
