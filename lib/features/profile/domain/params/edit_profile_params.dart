class EditProfileParams {
  final String userName;
  final String firstName;
  final String lastName;
  final String avatarIcon;
  final String? bio;
  final double? rate;
  final int? tripCount;
  final bool onboardingCompleted;

  EditProfileParams({
    required this.userName,
    this.bio,
    required this.firstName,
    required this.lastName,
    required this.avatarIcon,
    this.rate,
    this.tripCount,
    required this.onboardingCompleted,
  });
}
