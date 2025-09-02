import 'package:bloc_test/bloc_test.dart';
import 'package:chat/core/errors/error_data.dart';
import 'package:chat/core/resources/data_state.dart';
import 'package:chat/core/services/user_service.dart';
import 'package:chat/features/auth/domain/entities/user_data.dart';
import 'package:chat/features/auth/domain/forms/sign_in_form.dart';
import 'package:chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat/features/auth/domain/useCases/sign_in_use_case.dart';
import 'package:chat/features/auth/presentation/cubit/signIn/sign_in_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

class UserServiceMock extends Mock implements UserService {}

void main() {
  late final AuthRepositoryMock authRepositoryMock;
  late final UserService userServiceMock;
  late final SignInCubit signInCubit;
  late final SignInState signInState;

  setUpAll(() {
    authRepositoryMock = AuthRepositoryMock();
    userServiceMock = UserServiceMock();

    signInCubit = SignInCubit(
      signInUseCase: SignInUseCase(authRepository: authRepositoryMock),
      userService: userServiceMock,
    );
    signInState = SignInState(
      emailController: signInCubit.emailController,
      passwordController: signInCubit.passwordController,
      error: "",
    );
  });

  group("Auth Cubit", () {
    SignInForm signInForm = const SignInForm(email: "a", password: "a");
    UserData userData = const UserData.empty();
    blocTest(
      'Should emit auth state without any errors',
      build: () => signInCubit,
      setUp: () => when(() => authRepositoryMock.signIn(signInForm))
          .thenAnswer((_) async => DataSuccess(data: userData)),
      act: (cubit) async {
        cubit.emailController.add("a");
        cubit.passwordController.add("a");
        await cubit.sigIn();
      },
      expect: () => <SignInState>[],
      verify: (_) => verify(() => authRepositoryMock.signIn(signInForm)).called(1),
    );

    blocTest(
      'Should emit auth state with sign in error at last',
      build: () => signInCubit,
      setUp: () => when(() => authRepositoryMock.signIn(signInForm))
          .thenAnswer((_) async => const DataFailure(error: ErrorData(message: "Invalid email"))),
      act: (cubit) async {
        cubit.emailController.add("a");
        cubit.passwordController.add("a");
        await cubit.sigIn();
      },
      expect: () => <SignInState>[signInState.copyWith(error: "Invalid email")],
      verify: (_) => verify(() => authRepositoryMock.signIn(signInForm)).called(1),
    );
  });
}
