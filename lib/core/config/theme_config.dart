import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryGreen = Color(0xFF059669);
  static const Color primaryPurple = Color(0xFF7C3AED);

  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF1D4ED8);
  static const Color secondaryGreen = Color(0xFF047857);
  static const Color secondaryPurple = Color(0xFF5B21B6);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundCard = Color(0xFFFFFFFF);

  // Role-specific Colors
  static const Color patientPrimary = primaryBlue;
  static const Color patientSecondary = secondaryBlue;
  static const Color patientBackground = Color(0xFFF0F9FF);

  static const Color doctorPrimary = primaryGreen;
  static const Color doctorSecondary = secondaryGreen;
  static const Color doctorBackground = Color(0xFFF0FDF4);

  static const Color adminPrimary = primaryPurple;
  static const Color adminSecondary = secondaryPurple;
  static const Color adminBackground = Color(0xFFF3E8FF);

  // Gradient Colors
  static const List<Color> patientGradient = [primaryBlue, secondaryBlue];
  static const List<Color> doctorGradient = [primaryGreen, secondaryGreen];
  static const List<Color> adminGradient = [primaryPurple, secondaryPurple];

  // Card Colors
  static const Color cardBlue = Color(0xFFF0F9FF);
  static const Color cardGreen = Color(0xFFF0FDF4);
  static const Color cardYellow = Color(0xFFFEF3C7);
  static const Color cardRed = Color(0xFFFEE2E2);
  static const Color cardPurple = Color(0xFFF3E8FF);
  static const Color cardGray = Color(0xFFF9FAFB);

  // Text Colors
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textTertiary = gray500;
  static const Color textDisabled = gray400;

  // Border Colors
  static const Color borderLight = gray200;
  static const Color borderMedium = gray300;
  static const Color borderDark = gray400;

  // Shadow Colors
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);
  static const Color shadowDark = Color(0x1F000000);

  // Get role-specific colors
  static Map<String, dynamic> getRoleColors(String role) {
    switch (role.toLowerCase()) {
      case 'patient':
        return {
          'primary': patientPrimary,
          'secondary': patientSecondary,
          'background': patientBackground,
          'gradient': patientGradient,
        };
      case 'doctor':
        return {
          'primary': doctorPrimary,
          'secondary': doctorSecondary,
          'background': doctorBackground,
          'gradient': doctorGradient,
        };
      case 'admin':
        return {
          'primary': adminPrimary,
          'secondary': adminSecondary,
          'background': adminBackground,
          'gradient': adminGradient,
        };
      default:
        return {
          'primary': primaryBlue,
          'secondary': secondaryBlue,
          'background': patientBackground,
          'gradient': patientGradient,
        };
    }
  }

  // Get status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warning;
      case 'approved':
      case 'completed':
        return success;
      case 'cancelled':
      case 'rejected':
        return error;
      default:
        return gray500;
    }
  }

  // Get card background color
  static Color getCardBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'blue':
        return cardBlue;
      case 'green':
        return cardGreen;
      case 'yellow':
        return cardYellow;
      case 'red':
        return cardRed;
      case 'purple':
        return cardPurple;
      default:
        return cardGray;
    }
  }
}
