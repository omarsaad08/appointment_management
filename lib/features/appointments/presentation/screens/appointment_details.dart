import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/config/theme_config.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppTheme.patientPrimary,
        foregroundColor: AppTheme.white,
        elevation: 0,
        title: Text(
          'Appointment Details',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          isDesktop
              ? 32
              : isTablet
              ? 24
              : 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _buildStatusCard(context, isDesktop, isTablet),
            const SizedBox(height: 24),

            // Doctor Information
            _buildDoctorInfo(context, isDesktop, isTablet),
            const SizedBox(height: 24),

            // Appointment Details
            _buildAppointmentInfo(context, isDesktop, isTablet),
            const SizedBox(height: 24),

            // Patient Information
            _buildPatientInfo(context, isDesktop, isTablet),
            const SizedBox(height: 24),

            // Medical Notes
            _buildMedicalNotes(context, isDesktop, isTablet),
            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(context, isDesktop, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, bool isDesktop, bool isTablet) {
    final status = appointment['status'] ?? 'Pending';
    final statusColor = AppTheme.getStatusColor(status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Appointment ID: #${appointment['id'] ?? 'APPT-001'}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(BuildContext context, bool isDesktop, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctor Information',
            style: GoogleFonts.inter(
              fontSize: isDesktop
                  ? 20
                  : isTablet
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
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
                  color: AppTheme.patientPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    isDesktop
                        ? 40
                        : isTablet
                        ? 35
                        : 30,
                  ),
                ),
                child: Icon(
                  Icons.medical_services,
                  color: AppTheme.patientPrimary,
                  size: isDesktop
                      ? 40
                      : isTablet
                      ? 35
                      : 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['doctorName'] ?? 'Dr. Emily Chen',
                      style: GoogleFonts.inter(
                        fontSize: isDesktop
                            ? 20
                            : isTablet
                            ? 18
                            : 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment['specialty'] ?? 'Cardiologist',
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 16 : 14,
                        color: AppTheme.patientPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppTheme.warning, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '4.9 (1,247 patients)',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentInfo(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment Details',
            style: GoogleFonts.inter(
              fontSize: isDesktop
                  ? 20
                  : isTablet
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.calendar_today,
            'Date',
            appointment['date'] ?? 'Today, December 15, 2024',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.access_time,
            'Time',
            appointment['time'] ?? '2:30 PM - 3:00 PM',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.location_on,
            'Location',
            appointment['location'] ?? 'Medical Center, Room 205',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.medical_services,
            'Type',
            appointment['type'] ?? 'Regular Consultation',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.attach_money,
            'Fee',
            appointment['fee'] ?? '\$150',
            isDesktop,
            isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Information',
            style: GoogleFonts.inter(
              fontSize: isDesktop
                  ? 20
                  : isTablet
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.person,
            'Name',
            appointment['patientName'] ?? 'Sarah Johnson',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.phone,
            'Phone',
            appointment['patientPhone'] ?? '+1 (555) 123-4567',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.email,
            'Email',
            appointment['patientEmail'] ?? 'sarah.johnson@email.com',
            isDesktop,
            isTablet,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.cake,
            'Age',
            appointment['patientAge'] ?? '32 years',
            isDesktop,
            isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalNotes(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medical Notes',
            style: GoogleFonts.inter(
              fontSize: isDesktop
                  ? 20
                  : isTablet
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.gray50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Text(
              appointment['notes'] ??
                  'Regular checkup appointment. Patient reports feeling well with no specific concerns. Routine examination scheduled.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    final status = appointment['status'] ?? 'Pending';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actions',
            style: GoogleFonts.inter(
              fontSize: isDesktop
                  ? 20
                  : isTablet
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          if (status == 'Pending') ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Rescheduling appointment...'),
                          backgroundColor: AppTheme.info,
                        ),
                      );
                    },
                    icon: const Icon(Icons.schedule, size: 16),
                    label: const Text('Reschedule'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.info,
                      foregroundColor: AppTheme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Canceling appointment...'),
                          backgroundColor: AppTheme.error,
                        ),
                      );
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: const Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.error,
                      side: BorderSide(color: AppTheme.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ] else if (status == 'Approved') ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting consultation...'),
                      backgroundColor: AppTheme.success,
                    ),
                  );
                },
                icon: const Icon(Icons.video_call, size: 16),
                label: const Text('Start Consultation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.success,
                  foregroundColor: AppTheme.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ] else if (status == 'Completed') ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Downloading prescription...'),
                          backgroundColor: AppTheme.info,
                        ),
                      );
                    },
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Download Prescription'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.info,
                      side: BorderSide(color: AppTheme.info),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Viewing medical report...'),
                          backgroundColor: AppTheme.patientPrimary,
                        ),
                      );
                    },
                    icon: const Icon(Icons.description, size: 16),
                    label: const Text('View Report'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.patientPrimary,
                      side: BorderSide(color: AppTheme.patientPrimary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening chat with doctor...'),
                    backgroundColor: AppTheme.patientPrimary,
                  ),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline, size: 16),
              label: const Text('Chat with Doctor'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.patientPrimary,
                side: BorderSide(color: AppTheme.patientPrimary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    bool isDesktop,
    bool isTablet,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.textTertiary),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.inter(fontSize: 14, color: AppTheme.textPrimary),
          ),
        ),
      ],
    );
  }
}
