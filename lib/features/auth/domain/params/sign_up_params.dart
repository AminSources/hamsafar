class SignUpParams {
  final String email;
  final String password;
  final String? userName;
  final String? displayName;

  SignUpParams({
    required this.email,
    required this.password,
    this.userName,
    this.displayName,
  });
}
