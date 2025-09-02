import 'package:chat/core/constants/api_paths.dart';
import 'package:chat/core/resources/data_state.dart';
import 'package:chat/core/services/network/network_client.dart';
import 'package:chat/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:chat/features/auth/data/models/user_data_model.dart';
import 'package:chat/features/auth/domain/forms/sign_in_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class NetworkClientMock extends Mock implements NetworkClient {}

class MultiPartClientMock extends Mock implements MultiPartClient {}

void main() {
  late final NetworkClientMock networkServiceMock;
  late final MultiPartClientMock multiPartServiceMock;
  late final AuthRemoteDataSourceImplementation authRemoteDataSourceImplementation;
  late final Map<String, dynamic> userJson;
  late final Map<String, dynamic> userDataJson;

  setUpAll(() {
    networkServiceMock = NetworkClientMock();
    multiPartServiceMock = MultiPartClientMock();
    authRemoteDataSourceImplementation = AuthRemoteDataSourceImplementation(
      networkClient: networkServiceMock,
      multiPartClient: multiPartServiceMock,
    );
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
    late final RequestForm requestForm;

    setUp(() {
      signInForm = const SignInForm(email: "", password: "");
      userDataModel = UserDataModel.fromJson(userDataJson["data"]);
      requestForm = RequestForm(signInUrl, data: signInForm.toJson);
    });

    test("Should return user data model after sign in", () async {
      /// Arrange
      when(() => networkServiceMock.post(requestForm))
          .thenAnswer((_) async => response(userDataJson));

      /// Act
      final result = await authRemoteDataSourceImplementation.signIn(signInForm);

      // /// Assert
      verify(() => networkServiceMock.post(requestForm)).called(1);
      expect(result, DataSuccess(data: userDataModel));
    });
  });
}
