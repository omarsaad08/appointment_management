import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/appointment_card.dart';
import '../../../../core/widgets/quick_action_button.dart';
import '../../../../core/widgets/medical_icon.dart';
import '../../../../core/config/theme_config.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  // Static data for demonstration
  final String patientName = "Sarah Johnson";
  final int notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop
                ? 32
                : isTablet
                ? 24
                : 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Upcoming Appointments Section
              _buildUpcomingAppointments(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Quick Actions Section
              _buildQuickActions(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Recent Appointments Section
              _buildRecentAppointments(context, isDesktop, isTablet),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(
        isDesktop
            ? 32
            : isTablet
            ? 28
            : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppTheme.patientGradient,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.patientPrimary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: isDesktop
                ? 80
                : isTablet
                ? 70
                : 60,
            height: isDesktop
                ? 80
                : isTablet
                ? 70
                : 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                isDesktop
                    ? 40
                    : isTablet
                    ? 35
                    : 30,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 20),

          // Welcome Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 18 : 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  patientName,
                  style: GoogleFonts.inter(
                    fontSize: isDesktop
                        ? 28
                        : isTablet
                        ? 24
                        : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'How are you feeling today?',
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 16 : 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          // Profile button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'profile'),
            icon: const Icon(Icons.person, color: Colors.white),
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const MedicalIcon(size: 24, color: Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            Text(
              'Upcoming Appointments',
              style: GoogleFonts.inter(
                fontSize: isDesktop
                    ? 24
                    : isTablet
                    ? 22
                    : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111827),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Next Appointment Card
        AppointmentCard(
          doctorName: 'Dr. Emily Chen',
          specialty: 'Cardiologist',
          date: 'Today, December 15, 2024',
          time: '2:30 PM - 3:00 PM',
          location: 'Medical Center, Room 205',
          isToday: true,
          isUpcoming: true,
          onViewDetails: () {
            Navigator.pushNamed(
              context,
              'appointment_details',
              arguments: {
                'id': 'APPT-001',
                'doctorName': 'Dr. Emily Chen',
                'specialty': 'Cardiologist',
                'date': 'Today, December 15, 2024',
                'time': '2:30 PM - 3:00 PM',
                'location': 'Medical Center, Room 205',
                'status': 'Approved',
                'type': 'Regular Consultation',
                'fee': '\$150',
                'patientName': 'Sarah Johnson',
                'patientPhone': '+1 (555) 123-4567',
                'patientEmail': 'sarah.johnson@email.com',
                'patientAge': '32 years',
                'notes':
                    'Regular checkup appointment. Patient reports feeling well with no specific concerns.',
              },
            );
          },
          onCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Canceling appointment...')),
            );
          },
          onReschedule: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rescheduling appointment...')),
            );
          },
        ),

        // Additional upcoming appointment
        AppointmentCard(
          doctorName: 'Dr. Michael Rodriguez',
          specialty: 'Dermatologist',
          date: 'Monday, December 18, 2024',
          time: '10:00 AM - 10:30 AM',
          location: 'Skin Care Clinic, Room 102',
          isToday: false,
          isUpcoming: true,
          onViewDetails: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Viewing appointment details...')),
            );
          },
          onCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Canceling appointment...')),
            );
          },
          onReschedule: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rescheduling appointment...')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.inter(
            fontSize: isDesktop
                ? 24
                : isTablet
                ? 22
                : 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 20),

        // Primary action - Book New Appointment
        QuickActionButton(
          icon: Icons.add_circle_outline,
          title: 'Book New Appointment',
          subtitle: 'Schedule with your preferred doctor',
          backgroundColor: const Color(0xFFF0F9FF),
          iconColor: const Color(0xFF3B82F6),
          isPrimary: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Opening appointment booking...')),
            );
          },
        ),
        const SizedBox(height: 16),

        // Grid of other quick actions
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop
              ? 4
              : isTablet
              ? 3
              : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isDesktop ? 1.2 : 1.1,
          children: [
            QuickActionButton(
              icon: Icons.search,
              title: 'Find Doctors',
              subtitle: 'Browse specialists',
              backgroundColor: AppTheme.cardGreen,
              iconColor: AppTheme.doctorPrimary,
              onTap: () {
                Navigator.pushNamed(context, 'all_doctors');
              },
            ),
            QuickActionButton(
              icon: Icons.folder_outlined,
              title: 'Medical Records',
              subtitle: 'View your history',
              backgroundColor: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFD97706),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening medical records...')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentAppointments(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Appointments',
              style: GoogleFonts.inter(
                fontSize: isDesktop
                    ? 24
                    : isTablet
                    ? 22
                    : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111827),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing all appointments...')),
                );
              },
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Recent appointment cards
        AppointmentCard(
          doctorName: 'Dr. Lisa Wang',
          specialty: 'General Practitioner',
          date: 'December 10, 2024',
          time: '11:00 AM - 11:30 AM',
          location: 'Family Health Center, Room 101',
          isToday: false,
          isUpcoming: false,
          onViewDetails: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Viewing appointment details...')),
            );
          },
        ),

        AppointmentCard(
          doctorName: 'Dr. James Thompson',
          specialty: 'Orthopedist',
          date: 'December 5, 2024',
          time: '3:15 PM - 4:00 PM',
          location: 'Sports Medicine Clinic, Room 301',
          isToday: false,
          isUpcoming: false,
          onViewDetails: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Viewing appointment details...')),
            );
          },
        ),
      ],
    );
  }
}
