import 'package:chat/core/resources/data_state.dart';
import 'package:chat/features/auth/data/models/userData/user_data_model.dart';
import 'package:chat/features/auth/domain/parameters/sign_in_param.dart';
import 'package:chat/features/auth/domain/repositories/auth_repo.dart';
import 'package:chat/features/auth/domain/useCases/sign_in_uc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late final SignInParameter parameter;
  late final AuthRepositoryMock authRepositoryMock;
  late final SignInUseCase signInUseCase;
  late final DataState<UserDataModel> successDataState;

  setUp(() {
    parameter = const SignInParameter(email: "", password: "");
    authRepositoryMock = AuthRepositoryMock();
    signInUseCase = SignInUseCase(authRepositoryMock);
    successDataState = DataSuccessSate(data: UserDataModel.empty());
  });

  test("Sign in use case test", () async {
    /// Arranging
    when(() => authRepositoryMock.signIn(parameter)).thenAnswer((_) async => successDataState);
    // Verify no interactions have occurred.
    verifyNever(() => authRepositoryMock.signIn(parameter));

    /// Act (interacting)
    final result = await signInUseCase.call(parameter);

    /// Assert
    expect(result, successDataState);
    verify(() => authRepositoryMock.signIn(parameter)).called(1);
    // When mocktail verifies an invocation, it is then excluded from further verifications.
    verifyNever(() => authRepositoryMock.signIn(parameter));
  });
}
