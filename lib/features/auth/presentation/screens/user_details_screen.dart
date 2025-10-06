import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/auth_user.dart';
import '../../data/repositories/auth_repository.dart';

class UserDetailsScreen extends StatefulWidget {
  final AuthUser user;
  final UserRole role;

  const UserDetailsScreen({super.key, required this.user, required this.role});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  // Patient specific controllers
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _bloodTypeController = TextEditingController();

  // Doctor specific controllers
  final _specialityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _registrationNumberController = TextEditingController();

  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _bloodTypeController.dispose();
    _specialityController.dispose();
    _experienceController.dispose();
    _qualificationsController.dispose();
    _registrationNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final profileData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
      };

      // Add role-specific data
      if (widget.role == UserRole.patient) {
        profileData.addAll({
          'age': _ageController.text,
          'height': _heightController.text,
          'weight': _weightController.text,
          'bloodType': _bloodTypeController.text,
        });
      } else if (widget.role == UserRole.doctor) {
        profileData.addAll({
          'speciality': _specialityController.text,
          'experience': _experienceController.text,
          'qualifications': _qualificationsController.text,
          'registrationNumber': _registrationNumberController.text,
        });
      }

      await _authRepository.updateUserProfile(widget.user.id, profileData);

      if (mounted) {
        // Navigate to the appropriate home screen based on role
        Navigator.pushReplacementNamed(context, _getHomeRoute());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getHomeRoute() {
    switch (widget.role) {
      case UserRole.patient:
        return 'patient_home';
      case UserRole.doctor:
        return 'doctor_home';
      case UserRole.admin:
        return 'admin_home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete Your Profile',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Step 2: Personal Information',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                // Common fields
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value?.isEmpty == true
                      ? 'Please enter your phone number'
                      : null,
                ),
                const SizedBox(height: 24),

                // Role-specific fields
                if (widget.role == UserRole.patient) ...[
                  Text(
                    'Medical Information',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Please enter your age' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height (cm)',
                      hintText: 'Enter your height',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      hintText: 'Enter your weight',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bloodTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Blood Type',
                      hintText: 'Enter your blood type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ] else if (widget.role == UserRole.doctor) ...[
                  Text(
                    'Professional Information',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _specialityController,
                    decoration: const InputDecoration(
                      labelText: 'Speciality',
                      hintText: 'Enter your medical speciality',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter your speciality'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience',
                      hintText: 'Enter years of experience',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter your years of experience'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _qualificationsController,
                    decoration: const InputDecoration(
                      labelText: 'Qualifications',
                      hintText: 'Enter your qualifications',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter your qualifications'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _registrationNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Medical Registration Number',
                      hintText: 'Enter your registration number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter your registration number'
                        : null,
                  ),
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Complete Registration'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
