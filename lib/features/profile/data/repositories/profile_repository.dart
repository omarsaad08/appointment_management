import '../models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getCurrentProfile();
  Future<void> logout();
}

class ProfileRepositoryImpl implements ProfileRepository {
  // For now return static data; will be swapped with API later
  @override
  Future<UserProfile> getCurrentProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Static sample profile; in real app you would fetch based on auth
    return UserProfile(
      id: 'u-1',
      name: 'Sarah Johnson',
      email: 'sarah.johnson@email.com',
      phone: '+1 (555) 123-4567',
      role: 'patient',
      extra: {'age': 32, 'height': 168, 'weight': 62, 'bloodType': 'O+'},
    );
  }

  @override
  Future<void> logout() async {
    // For static implementation do nothing; real impl would clear tokens
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
