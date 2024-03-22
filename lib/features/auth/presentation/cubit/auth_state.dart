part of 'auth_cubit.dart';

class AuthState {
  final String signInError;
  final String signUpError;
  final String updateProfileError;

  const AuthState({
    required this.signInError,
    required this.signUpError,
    required this.updateProfileError,
  });

  factory AuthState.initial() => const AuthState(
        signInError: "",
        signUpError: "",
        updateProfileError: "",
      );

  AuthState copyWith({
    String? signInError,
    String? signUpError,
    String? updateProfileError,
  }) =>
      AuthState(
        signInError: signInError ?? this.signInError,
        signUpError: signUpError ?? this.signUpError,
        updateProfileError: updateProfileError ?? this.updateProfileError,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      other.signInError == signInError &&
      other.signUpError == signUpError &&
      other.updateProfileError == updateProfileError;

  @override
  int get hashCode => Object.hash(
        signInError,
        signUpError,
        updateProfileError,
      );
}
