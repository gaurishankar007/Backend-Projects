import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/error_data.dart';
import '../../../../core/errors/exception_handler.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/auth_header.dart';
import '../../domain/forms/sign_in_form.dart';
import '../../domain/forms/sign_up_form.dart';
import '../models/user_data_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  FutureData<UserDataModel> signIn(SignInForm form);
  FutureData<UserDataModel> signUp(SignUpForm form);
  FutureData<UserModel> updateProfile(String imagePath);
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImplementation({required this.dio});

  @override
  FutureData<UserDataModel> signIn(SignInForm parameter) async {
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
        return DataSuccess(data: userData);
      }

      return DataFailure<UserDataModel>(
        error: ErrorData(
          error: "Authentication error",
          message: res.data["error"],
          type: ErrorType.invalidUserCredential,
        ),
      );
    });
  }

  @override
  FutureData<UserDataModel> signUp(SignUpForm parameter) async {
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
        return DataSuccess(data: userData);
      }

      return DataFailure<UserDataModel>(
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
        "profile": await MultipartFile.fromFile(
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
        return DataSuccess(data: user);
      }

      return DataFailure<UserModel>(
        error: ErrorData(
          error: "Profile upload error",
          message: res.data["error"],
        ),
      );
    });
  }
}
