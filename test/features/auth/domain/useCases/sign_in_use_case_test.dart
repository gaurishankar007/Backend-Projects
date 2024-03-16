import 'package:chat/core/resources/data_state.dart';
import 'package:chat/features/auth/domain/entities/user_data.dart';
import 'package:chat/features/auth/domain/forms/sign_in_form.dart';
import 'package:chat/features/auth/domain/repositories/auth_repo.dart';
import 'package:chat/features/auth/domain/useCases/sign_in_uc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late final SignInForm parameter;
  late final AuthRepositoryMock authRepositoryMock;
  late final SignInUseCase signInUseCase;
  late final DataState<UserData> successDataState;

  setUp(() {
    parameter = const SignInForm(email: "", password: "");
    authRepositoryMock = AuthRepositoryMock();
    signInUseCase = SignInUseCase(authRepositoryMock);
    successDataState = const DataSuccessSate(data: UserData.empty());
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
