enum UserRole {
  patient,
  doctor,
  admin;

  String get displayName {
    switch (this) {
      case UserRole.patient:
        return 'Patient';
      case UserRole.doctor:
        return 'Doctor';
      case UserRole.admin:
        return 'Admin';
    }
  }
}

class AuthUser {
  final String id;
  final String email;
  final String password;
  final UserRole role;
  final Map<String, dynamic> profileData;

  AuthUser({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    this.profileData = const {},
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      profileData: json['profileData'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
      'profileData': profileData,
    };
  }

  AuthUser copyWith({
    String? id,
    String? email,
    String? password,
    UserRole? role,
    Map<String, dynamic>? profileData,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      profileData: profileData ?? this.profileData,
    );
  }
}
