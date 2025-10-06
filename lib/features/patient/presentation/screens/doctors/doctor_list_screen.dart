import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/doctor_card.dart';
import '../../../../doctor/data/repositories/doctor_repository.dart';
import '../../../../doctor/data/models/doctor.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final DoctorRepository _doctorRepository = DoctorRepositoryImpl();
  List<Doctor> _doctors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    try {
      final doctors = await _doctorRepository.getDoctors();
      setState(() {
        _doctors = doctors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading doctors: \${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Doctors',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _doctors.length,
              itemBuilder: (context, index) {
                final doctor = _doctors[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DoctorCard(
                    doctor: doctor,
                    onTap: () {
                      // Navigate to doctor details screen
                    },
                    onBookAppointment: () {
                      // Navigate to appointment booking screen
                    },
                  ),
                );
              },
            ),
    );
  }
}
