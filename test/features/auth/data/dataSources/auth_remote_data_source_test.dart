import 'package:chat/core/constants/api_paths.dart';
import 'package:chat/core/resources/data_state.dart';
import 'package:chat/core/services/network_service.dart';
import 'package:chat/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:chat/features/auth/data/models/user_data_model.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domain/forms/sign_in_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class NetworkServiceMock extends Mock implements NetworkService {}

void main() {
  late final NetworkServiceMock networkServiceMock;
  late final AuthRemoteDataSourceImplementation authRemoteDataSourceImplementation;
  late final Map<String, dynamic> userJson;
  late final Map<String, dynamic> userDataJson;

  setUpAll(() {
    networkServiceMock = NetworkServiceMock();
    authRemoteDataSourceImplementation =
        AuthRemoteDataSourceImplementation(networkService: networkServiceMock);
    userJson = {
      "_id": "d7b9144420",
      "email": "user@gmail.com",
      "name": "User User",
      "profile": "user.jpeg"
    };
    userDataJson = {
      "status": true,
      "data": {
        "user": userJson,
        "accessToken": "35-zGA-3R4oFJZhsUOOB9OSif9dda6SgW49eKo",
        "refreshToken": "xB78_oUIRYnlKJBxcJAaU2KoFf9epFSwO8"
      }
    };
  });

  Response response(dynamic data) => Response(data: data, requestOptions: RequestOptions());

  group("Account", () {
    late final SignInForm signInForm;
    late final UserDataModel userDataModel;
    late final DioForm dioForm;

    setUp(() {
      signInForm = const SignInForm(email: "", password: "");
      userDataModel = UserDataModel.fromJson(userDataJson["data"]);
      dioForm = DioForm(signInUrl, data: signInForm.toJson);
    });

    test("Should return user data model after sign in", () async {
      /// Arrange
      when(() => networkServiceMock.post(dioForm)).thenAnswer((_) async => response(userDataJson));

      /// Act
      final result = await authRemoteDataSourceImplementation.signIn(signInForm);

      // /// Assert
      verify(() => networkServiceMock.post(dioForm)).called(1);
      expect(result, DataSuccess(data: userDataModel));
    });
  });

  group("Account", () {
    late final DioFormData dioFormData;
    late final UserModel userModel;
    late final DioForm dioForm;

    setUp(() {
      dioFormData = FormData.fromMap({"profile": ""});
      userModel = UserModel.fromJson(userJson);
      dioForm = DioForm(updateProfileUrl, data: dioFormData);
    });

    test("Should return user  model after sign in", () async {
      /// Arrange
      when(() => networkServiceMock.put(dioForm))
          .thenAnswer((_) async => response({"status": true, "data": userJson}));

      /// Act
      final result = await authRemoteDataSourceImplementation.updateProfile(dioFormData);

      // /// Assert
      verify(() => networkServiceMock.put(dioForm)).called(1);
      expect(result, DataSuccess(data: userModel));
    });
  });
}
