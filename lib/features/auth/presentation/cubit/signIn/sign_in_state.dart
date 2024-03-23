part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final BehaviorSubject<String> emailController;
  final BehaviorSubject<String> passwordController;
  final String error;

  const SignInState({
    required this.emailController,
    required this.passwordController,
    required this.error,
  });

  factory SignInState.initial() => SignInState(
        emailController: BehaviorSubject<String>(),
        passwordController: BehaviorSubject<String>(),
        error: "",
      );

  SignInState copyWith({
    BehaviorSubject<String>? emailController,
    BehaviorSubject<String>? passwordController,
    String? error,
  }) =>
      SignInState(
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        error,
      ];
}
