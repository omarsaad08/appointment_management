import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/overview_card.dart';
import '../../../../core/widgets/appointment_list_item.dart';
import '../../../../core/widgets/quick_action_button.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  // Static data for demonstration
  final String doctorName = "Dr. Emily Chen";
  final int notificationCount = 5;
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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

              // Today's Overview Cards
              _buildTodaysOverview(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Today's Appointments
              _buildTodaysAppointments(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Quick Actions
              _buildQuickActions(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Pending Approvals
              _buildPendingApprovals(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // This Week's Schedule
              _buildWeeklySchedule(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Recent Patients
              _buildRecentPatients(context, isDesktop, isTablet),
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF059669), Color(0xFF047857)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.3),
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
            child: const Icon(
              Icons.medical_services,
              color: Colors.white,
              size: 32,
            ),
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
                  doctorName,
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
                  'Cardiologist • 4.9 ⭐ • 1,247 patients',
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 16 : 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Notifications
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications feature coming soon!'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          notificationCount.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysOverview(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Overview",
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
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop
              ? 4
              : isTablet
              ? 2
              : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isDesktop ? 1.3 : 1.2,
          children: [
            OverviewCard(
              title: 'Total Appointments',
              value: '12',
              subtitle: 'Today',
              icon: Icons.calendar_today,
              backgroundColor: const Color(0xFFF0F9FF),
              iconColor: const Color(0xFF3B82F6),
              trend: '+2',
              isPositiveTrend: true,
            ),
            OverviewCard(
              title: 'Pending Approvals',
              value: '3',
              subtitle: 'Awaiting response',
              icon: Icons.pending_actions,
              backgroundColor: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFF59E0B),
            ),
            OverviewCard(
              title: 'Completed',
              value: '8',
              subtitle: 'Consultations done',
              icon: Icons.check_circle,
              backgroundColor: const Color(0xFFF0FDF4),
              iconColor: const Color(0xFF10B981),
            ),
            OverviewCard(
              title: 'Revenue Today',
              value: '\$1,240',
              subtitle: 'From consultations',
              icon: Icons.attach_money,
              backgroundColor: const Color(0xFFF3E8FF),
              iconColor: const Color(0xFF8B5CF6),
              trend: '+15%',
              isPositiveTrend: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaysAppointments(
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
              "Today's Appointments",
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFilter,
                  isDense: true,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF374151),
                  ),
                  items: ['All', 'Pending', 'Approved', 'Completed'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              AppointmentListItem(
                patientName: 'Sarah Johnson',
                time: '9:00 AM - 9:30 AM',
                status: 'Approved',
                reason: 'Regular checkup',
                onStartConsultation: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Starting consultation...')),
                  );
                },
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing patient details...')),
                  );
                },
              ),
              AppointmentListItem(
                patientName: 'Michael Rodriguez',
                time: '10:15 AM - 10:45 AM',
                status: 'Pending',
                reason: 'Chest pain evaluation',
                onApprove: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment approved!')),
                  );
                },
                onReject: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment rejected!')),
                  );
                },
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing patient details...')),
                  );
                },
              ),
              AppointmentListItem(
                patientName: 'Lisa Wang',
                time: '11:30 AM - 12:00 PM',
                status: 'Completed',
                reason: 'Follow-up visit',
                showActions: false,
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Viewing appointment details...'),
                    ),
                  );
                },
              ),
            ],
          ),
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
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop
              ? 3
              : isTablet
              ? 2
              : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isDesktop ? 1.1 : 1.0,
          children: [
            QuickActionButton(
              icon: Icons.schedule,
              title: 'View My Schedule',
              subtitle: 'Check availability',
              backgroundColor: const Color(0xFFF0F9FF),
              iconColor: const Color(0xFF3B82F6),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening schedule...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.edit_calendar,
              title: 'Manage Availability',
              subtitle: 'Update time slots',
              backgroundColor: const Color(0xFFF0FDF4),
              iconColor: const Color(0xFF059669),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Managing availability...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.list_alt,
              title: 'All Appointments',
              subtitle: 'View complete list',
              backgroundColor: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFD97706),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing all appointments...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.message,
              title: 'Patient Messages',
              subtitle: 'Chat with patients',
              backgroundColor: const Color(0xFFF3E8FF),
              iconColor: const Color(0xFF8B5CF6),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening messages...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.folder,
              title: 'Medical Records',
              subtitle: 'Patient history',
              backgroundColor: const Color(0xFFFEE2E2),
              iconColor: const Color(0xFFEF4444),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening medical records...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.analytics,
              title: 'Earnings Report',
              subtitle: 'View analytics',
              backgroundColor: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF10B981),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening earnings report...')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingApprovals(
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
              'Pending Approvals',
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '3 pending',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD97706),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              AppointmentListItem(
                patientName: 'David Kim',
                time: 'Tomorrow, 2:00 PM',
                status: 'Pending',
                reason: 'Annual physical examination',
                onApprove: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment approved!')),
                  );
                },
                onReject: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment rejected!')),
                  );
                },
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing patient details...')),
                  );
                },
              ),
              AppointmentListItem(
                patientName: 'Emma Thompson',
                time: 'Friday, 10:30 AM',
                status: 'Pending',
                reason: 'Heart condition follow-up',
                onApprove: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment approved!')),
                  );
                },
                onReject: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment rejected!')),
                  );
                },
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing patient details...')),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklySchedule(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This Week's Schedule",
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildScheduleDay(
                'Monday',
                '8 appointments',
                '9:00 AM - 5:00 PM',
              ),
              const Divider(),
              _buildScheduleDay(
                'Tuesday',
                '6 appointments',
                '9:00 AM - 3:00 PM',
              ),
              const Divider(),
              _buildScheduleDay(
                'Wednesday',
                '10 appointments',
                '9:00 AM - 6:00 PM',
              ),
              const Divider(),
              _buildScheduleDay(
                'Thursday',
                '7 appointments',
                '9:00 AM - 4:00 PM',
              ),
              const Divider(),
              _buildScheduleDay(
                'Friday',
                '5 appointments',
                '9:00 AM - 2:00 PM',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleDay(String day, String appointments, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              appointments,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              hours,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPatients(
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
              'Recent Patients',
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
                  const SnackBar(content: Text('Viewing all patients...')),
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildPatientItem(
                'Sarah Johnson',
                'Last visit: Dec 10',
                'Regular checkup',
              ),
              const Divider(),
              _buildPatientItem(
                'Michael Rodriguez',
                'Last visit: Dec 8',
                'Chest pain evaluation',
              ),
              const Divider(),
              _buildPatientItem(
                'Lisa Wang',
                'Last visit: Dec 5',
                'Follow-up visit',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPatientItem(String name, String lastVisit, String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.person, color: Color(0xFF3B82F6), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lastVisit,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                Text(
                  reason,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF9CA3AF),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening patient records...')),
              );
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
