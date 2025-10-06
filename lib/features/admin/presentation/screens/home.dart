import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/quick_action_button.dart';
import '../../../../core/widgets/activity_item.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // Static data for demonstration
  final String adminName = "Admin Dashboard";
  final int notificationCount = 8;

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

              // Quick Actions
              _buildQuickActions(context, isDesktop, isTablet),
              const SizedBox(height: 32),

              // Appointments Overview
              _buildAppointmentsOverview(context, isDesktop, isTablet),
              const SizedBox(height: 20),

              // Recent Activities and Pending Actions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTablet)
                    Expanded(flex: 3, child: _buildRecentActivities(context)),
                  if (isTablet) const SizedBox(width: 20),
                  if (isTablet)
                    Expanded(flex: 2, child: _buildPendingActions(context)),
                ],
              ),
              if (!isTablet) ...[
                _buildRecentActivities(context),
                const SizedBox(height: 20),
                _buildPendingActions(context),
              ],
              const SizedBox(height: 20),

              // Users Overview and Doctor Performance
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: _buildUsersOverview(context)),
                    const SizedBox(width: 20),
                    Expanded(flex: 1, child: _buildDoctorsPerformance(context)),
                  ],
                )
              else ...[
                _buildUsersOverview(context),
                const SizedBox(height: 20),
                _buildDoctorsPerformance(context),
              ],
              const SizedBox(height: 20),

              // System Health
              _buildSystemHealth(context),
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
          colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // System Icon
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
              Icons.admin_panel_settings,
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
                  'System Administration',
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 18 : 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  adminName,
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
                  'Manage users, appointments, and system settings',
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
                        content: Text(
                          'System notifications feature coming soon!',
                        ),
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
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'profile'),
            icon: const Icon(Icons.person, color: Colors.white, size: 28),
            tooltip: 'Profile',
          ),
        ],
      ),
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
              ? 4
              : isTablet
              ? 2
              : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isDesktop ? 1.1 : 1.0,
          children: [
            QuickActionButton(
              icon: Icons.calendar_month,
              title: 'View Appointments',
              subtitle: 'All appointments',
              backgroundColor: const Color(0xFFF0FDF4),
              iconColor: const Color(0xFF059669),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening appointments...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.medical_services,
              title: 'Manage Doctors',
              subtitle: 'Doctor approvals',
              backgroundColor: const Color(0xFFFEE2E2),
              iconColor: const Color(0xFFEF4444),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening doctor management...')),
                );
              },
            ),
            QuickActionButton(
              icon: Icons.person,
              title: 'Manage Patients',
              subtitle: 'Patient records',
              backgroundColor: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF10B981),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening patient management...'),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
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
              ActivityItem(
                title: 'New doctor registration',
                subtitle: 'Dr. Sarah Wilson registered',
                time: '2 min ago',
                icon: Icons.person_add,
                iconColor: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFFF0F9FF),
              ),
              ActivityItem(
                title: 'Appointment completed',
                subtitle: 'Patient John Doe completed consultation',
                time: '5 min ago',
                icon: Icons.check_circle,
                iconColor: const Color(0xFF10B981),
                backgroundColor: const Color(0xFFF0FDF4),
              ),
              ActivityItem(
                title: 'New patient registration',
                subtitle: 'Emma Thompson joined the platform',
                time: '12 min ago',
                icon: Icons.person,
                iconColor: const Color(0xFF8B5CF6),
                backgroundColor: const Color(0xFFF3E8FF),
              ),
              ActivityItem(
                title: 'System backup completed',
                subtitle: 'Daily backup successful',
                time: '1 hour ago',
                icon: Icons.backup,
                iconColor: const Color(0xFFD97706),
                backgroundColor: const Color(0xFFFEF3C7),
              ),
              ActivityItem(
                title: 'Doctor approval',
                subtitle: 'Dr. Michael Chen approved',
                time: '2 hours ago',
                icon: Icons.verified,
                iconColor: const Color(0xFF059669),
                backgroundColor: const Color(0xFFF0FDF4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPendingActions(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pending Actions',
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
              _buildPendingItem(
                '3',
                'New doctor registrations',
                const Color(0xFFF59E0B),
              ),
              const SizedBox(height: 12),
              _buildPendingItem(
                '2',
                'Reported issues',
                const Color(0xFFEF4444),
              ),
              const SizedBox(height: 12),
              _buildPendingItem('1', 'System alerts', const Color(0xFF8B5CF6)),
              const SizedBox(height: 12),
              _buildPendingItem('5', 'Flagged users', const Color(0xFF6B7280)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPendingItem(String count, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                count,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: color),
        ],
      ),
    );
  }

  Widget _buildUsersOverview(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Users',
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
              _buildUserItem(
                'Dr. Sarah Wilson',
                'Doctor',
                '2 min ago',
                const Color(0xFF3B82F6),
              ),
              const Divider(),
              _buildUserItem(
                'Emma Thompson',
                'Patient',
                '12 min ago',
                const Color(0xFF8B5CF6),
              ),
              const Divider(),
              _buildUserItem(
                'Dr. Michael Chen',
                'Doctor',
                '2 hours ago',
                const Color(0xFF3B82F6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserItem(
    String name,
    String role,
    String time,
    Color roleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: roleColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              role == 'Doctor' ? Icons.medical_services : Icons.person,
              color: roleColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsOverview(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Appointments',
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
              _buildAppointmentItem('156', 'Total', const Color(0xFF3B82F6)),
              const Divider(),
              _buildAppointmentItem('89', 'Completed', const Color(0xFF10B981)),
              const Divider(),
              _buildAppointmentItem('45', 'Pending', const Color(0xFFF59E0B)),
              const Divider(),
              _buildAppointmentItem('22', 'Cancelled', const Color(0xFFEF4444)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentItem(String count, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ),
          Text(
            count,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsPerformance(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doctors Performance',
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
              _buildDoctorPerformanceItem(
                'Dr. Emily Chen',
                '4.9 ⭐',
                '247 patients',
                const Color(0xFF10B981),
              ),
              const Divider(),
              _buildDoctorPerformanceItem(
                'Dr. Michael Rodriguez',
                '4.8 ⭐',
                '189 patients',
                const Color(0xFF3B82F6),
              ),
              const Divider(),
              _buildDoctorPerformanceItem(
                'Dr. Lisa Wang',
                '4.7 ⭐',
                '156 patients',
                const Color(0xFF8B5CF6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorPerformanceItem(
    String name,
    String rating,
    String patients,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.medical_services, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                Text(
                  patients,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Text(
            rating,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemHealth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Health',
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
              _buildSystemHealthItem(
                'Server Status',
                'Online',
                const Color(0xFF10B981),
              ),
              const Divider(),
              _buildSystemHealthItem(
                'Database',
                'Healthy',
                const Color(0xFF10B981),
              ),
              const Divider(),
              _buildSystemHealthItem(
                'API Response',
                '45ms',
                const Color(0xFF3B82F6),
              ),
              const Divider(),
              _buildSystemHealthItem(
                'Error Rate',
                '0.1%',
                const Color(0xFF10B981),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSystemHealthItem(
    String component,
    String status,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              component,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ),
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
