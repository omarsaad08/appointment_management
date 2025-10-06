import 'dart:async';
import '../../../../core/config/api_config.dart';
import '../models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getCurrentUser();
  Future<AuthUser> login(String email, String password);
  Future<AuthUser> signup(String email, String password, UserRole role);
  Future<AuthUser> updateUserProfile(
    String userId,
    Map<String, dynamic> profileData,
  );
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  // In-memory static user storage for demonstration
  static final Map<String, AuthUser> _users = {
    'admin@gmail.com': AuthUser(
      id: 'admin',
      email: 'admin@gmail.com',
      password: 'admin123',
      role: UserRole.admin,
      profileData: {'name': 'Admin User', 'phone': '+1234567890'},
    ),
  };

  AuthUser? _currentUser;

  @override
  Future<AuthUser?> getCurrentUser() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }

  @override
  Future<AuthUser> login(String email, String password) async {
    if (!ApiConfig.useApiData) {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final user = _users[email];
      if (user == null || user.password != password) {
        throw Exception('Invalid credentials');
      }

      _currentUser = user;
      return user;
    }

    // TODO: Implement API login
    throw UnimplementedError('API login not implemented');
  }

  @override
  Future<AuthUser> signup(String email, String password, UserRole role) async {
    if (!ApiConfig.useApiData) {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      if (_users.containsKey(email)) {
        throw Exception('Email already exists');
      }

      if (email == 'admin@gmail.com' && role != UserRole.admin) {
        throw Exception('Admin email can only be used with admin role');
      }

      if (email != 'admin@gmail.com' && role == UserRole.admin) {
        throw Exception('Admin role is restricted');
      }

      final newUser = AuthUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        password: password,
        role: role,
      );

      _users[email] = newUser;
      _currentUser = newUser;
      return newUser;
    }

    // TODO: Implement API signup
    throw UnimplementedError('API signup not implemented');
  }

  @override
  Future<AuthUser> updateUserProfile(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    if (!ApiConfig.useApiData) {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final user = _users.values.firstWhere(
        (user) => user.id == userId,
        orElse: () => throw Exception('User not found'),
      );

      final updatedUser = user.copyWith(
        profileData: {...user.profileData, ...profileData},
      );

      _users[user.email] = updatedUser;
      if (_currentUser?.id == userId) {
        _currentUser = updatedUser;
      }

      return updatedUser;
    }

    // TODO: Implement API profile update
    throw UnimplementedError('API profile update not implemented');
  }

  @override
  Future<void> logout() async {
    if (!ApiConfig.useApiData) {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));
      _currentUser = null;
      return;
    }

    // TODO: Implement API logout
    throw UnimplementedError('API logout not implemented');
  }
}
