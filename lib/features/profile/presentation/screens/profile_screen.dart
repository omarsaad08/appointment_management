import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/profile_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();
  bool _isLoading = true;
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _profileRepository.getCurrentProfile();
      if (mounted) {
        setState(() {
          _profile = profile;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
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
      await _profileRepository.logout();
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_profile == null)
      return const Scaffold(body: Center(child: Text('No profile available')));

    final profile = _profile!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: _handleLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      profile.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.role.toUpperCase(),
                    style: GoogleFonts.inter(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Basic Information',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildProfileSection('Name', profile.name),
            _buildProfileSection('Email', profile.email),
            _buildProfileSection('Phone', profile.phone),

            const SizedBox(height: 16),
            if (profile.role == 'patient') ...[
              Text(
                'Medical Information',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildProfileSection('Age', profile.extra['age']?.toString()),
              _buildProfileSection(
                'Height',
                profile.extra['height']?.toString(),
              ),
              _buildProfileSection(
                'Weight',
                profile.extra['weight']?.toString(),
              ),
              _buildProfileSection(
                'Blood Type',
                profile.extra['bloodType']?.toString(),
              ),
            ] else if (profile.role == 'doctor') ...[
              Text(
                'Professional Information',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildProfileSection(
                'Specialization',
                profile.extra['specialization']?.toString(),
              ),
              _buildProfileSection(
                'Experience',
                profile.extra['experience']?.toString(),
              ),
              _buildProfileSection(
                'Qualifications',
                profile.extra['qualifications']?.toString(),
              ),
              _buildProfileSection(
                'Languages',
                (profile.extra['languages'] as List<dynamic>?)?.join(', '),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
