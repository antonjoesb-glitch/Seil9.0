class UserProfile {
  const UserProfile({
    this.id = '',
    this.fullName = 'Conference User',
    this.email = '',
    this.organization = 'Not Specified',
    this.role = 'Attendee',
    this.bio = '',
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: '${map['id'] ?? ''}',
      fullName: '${map['full_name'] ?? 'Conference User'}',
      email: '${map['email'] ?? ''}',
      organization: '${map['organization'] ?? 'Not Specified'}',
      role: '${map['role'] ?? 'Attendee'}',
      bio: '${map['bio'] ?? ''}',
    );
  }

  final String id;
  final String fullName;
  final String email;
  final String organization;
  final String role;
  final String bio;

  bool get needsSetup =>
      fullName == 'Conference User' ||
      fullName.isEmpty ||
      organization == 'Not Specified' ||
      organization.isEmpty;
}
