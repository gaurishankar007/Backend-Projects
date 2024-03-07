import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/auth_header.dart';
import '../../data/models/userData/user_data_model.dart';
import '../../domain/parameters/sign_in_param.dart';
import '../../domain/parameters/sign_up_param.dart';
import '../models/user/user_model.dart';

abstract class AuthRemoteSource {
  FutureData<UserDataModel> signIn(SignInParameter parameter);
  FutureData<UserDataModel> signUp(SignUpParameter parameter);
  FutureData<UserModel> updateProfile(String imagePath);
}

class AuthRemoteSourceImplementation implements AuthRemoteSource {
  final Dio dio;

  AuthRemoteSourceImplementation({required this.dio});

  @override
  FutureData<UserDataModel> signIn(SignInParameter parameter) async {
    return await exceptionHandler(() async {
      final res = await dio.post(
        signInUrl,
        data: parameter.toJson,
        options: Options(
          validateStatus: (status) => status == 200 || status == 401,
        ),
      );

      bool status = res.data["status"];

      if (status) {
        UserDataModel userData = UserDataModel.fromJson(res.data["data"]);
        return DataSuccessSate(data: userData);
      }

      return DataFailureSate<UserDataModel>(
        error: ErrorData(
          error: "Authentication error",
          message: res.data["error"],
          type: ErrorType.invalidUserCredential,
        ),
      );
    });
  }

  @override
  FutureData<UserDataModel> signUp(SignUpParameter parameter) async {
    return await exceptionHandler(() async {
      final res = await dio.post(
        signUpUrl,
        data: parameter.toJson,
        options: Options(
          validateStatus: (status) => status == 200 || status == 400,
        ),
      );

      bool status = res.data["status"];

      if (status) {
        UserDataModel userData = UserDataModel.fromJson(res.data["data"]);
        return DataSuccessSate(data: userData);
      }

      return DataFailureSate<UserDataModel>(
        error: ErrorData(
          error: "Registration error",
          message: res.data["error"],
          type: ErrorType.badRequest,
        ),
      );
    });
  }

  @override
  FutureData<UserModel> updateProfile(String imagePath) async {
    return await exceptionHandler(() async {
      FormData data = FormData.fromMap({
        "profilePic": await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split("/").last,
          contentType: MediaType("image", "jpg"),
        ),
      });

      final res = await dio.put(
        updateProfileUrl,
        data: data,
        options: Options(
          headers: reqHeaders(isFormData: true),
          validateStatus: (status) => status == 200 || status == 400,
        ),
      );

      bool status = res.data["status"];
      if (status) {
        UserModel user = UserModel.fromJson(res.data["data"]);
        return DataSuccessSate(data: user);
      }

      return DataFailureSate<UserModel>(
        error: ErrorData(
          error: "Profile upload error",
          message: res.data["error"],
        ),
      );
    });
  }
}
