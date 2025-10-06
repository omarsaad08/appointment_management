import 'package:appointment_management/core/widgets/doctor_card.dart';
import 'package:appointment_management/features/doctor/data/models/doctor.dart';
import 'package:appointment_management/features/patient/presentation/screens/booking/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Profile',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Doctor card with basic info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DoctorCard(
                doctor: doctor,
                onTap: () {},
                onBookAppointment: () {},
              ),
            ),

            // Detailed information sections
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professional Information',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProfileSection('Speciality', doctor.specialization),
                  _buildProfileSection(
                    'Experience',
                    '${doctor.experienceYears} years',
                  ),
                  _buildProfileSection('Qualifications', doctor.qualifications),
                  _buildProfileSection(
                    'Languages',
                    doctor.languages.join(', '),
                  ),
                  _buildProfileSection(
                    'Available Days',
                    doctor.availableDays.join(', '),
                  ),

                  const SizedBox(height: 32),
                  Text(
                    'About',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor.about,
                    style: GoogleFonts.inter(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(doctor: doctor),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Book Appointment'),
          ),
        ),
      ),
    );
  }
}
