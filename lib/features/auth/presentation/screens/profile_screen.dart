import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/auth_user.dart';
import '../../data/repositories/auth_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  bool _isLoading = true;
  AuthUser? _user;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = await _authRepository.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    try {
      await _authRepository.logout();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildProfileSection(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value ?? 'Not provided',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPatientProfile(Map<String, dynamic> profileData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medical Information',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildProfileSection('Age', profileData['age']?.toString()),
        _buildProfileSection('Height', '${profileData['height']} cm'),
        _buildProfileSection('Weight', '${profileData['weight']} kg'),
        _buildProfileSection('Blood Type', profileData['bloodType']),
      ],
    );
  }

  Widget _buildDoctorProfile(Map<String, dynamic> profileData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Information',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildProfileSection('Speciality', profileData['speciality']),
        _buildProfileSection(
          'Experience',
          '${profileData['experience']} years',
        ),
        _buildProfileSection('Qualifications', profileData['qualifications']),
        _buildProfileSection(
          'Registration Number',
          profileData['registrationNumber'],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_user == null) {
      return const Scaffold(body: Center(child: Text('Error loading profile')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _handleLogout),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar and role
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        _user!.profileData['name']?[0].toUpperCase() ?? '?',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _user!.role.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Basic information
              Text(
                'Basic Information',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileSection('Name', _user!.profileData['name']),
              _buildProfileSection('Email', _user!.email),
              _buildProfileSection('Phone', _user!.profileData['phone']),
              const SizedBox(height: 24),

              // Role-specific information
              if (_user!.role == UserRole.patient)
                _buildPatientProfile(_user!.profileData)
              else if (_user!.role == UserRole.doctor)
                _buildDoctorProfile(_user!.profileData),
            ],
          ),
        ),
      ),
    );
  }
}
