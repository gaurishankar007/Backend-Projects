part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final BehaviorSubject<String> nameController;
  final BehaviorSubject<String> emailController;
  final BehaviorSubject<String> passwordController;
  final BehaviorSubject<String> confirmPasswordController;
  final String error;

  const SignUpState({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.error,
  });

  factory SignUpState.initial() => SignUpState(
        error: "",
        nameController: BehaviorSubject<String>(),
        emailController: BehaviorSubject<String>(),
        passwordController: BehaviorSubject<String>(),
        confirmPasswordController: BehaviorSubject<String>(),
      );

  SignUpState copyWith({
    BehaviorSubject<String>? nameController,
    BehaviorSubject<String>? emailController,
    BehaviorSubject<String>? passwordController,
    BehaviorSubject<String>? confirmPasswordController,
    String? error,
  }) =>
      SignUpState(
        nameController: nameController ?? this.nameController,
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        nameController,
        emailController,
        passwordController,
        confirmPasswordController,
        error,
      ];
}
