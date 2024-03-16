class SignInForm {
  final String email;
  final String password;

  const SignInForm({required this.email, required this.password});
  Map<String, String> get toJson => {
        "email": email,
        "password": password,
      };
}
