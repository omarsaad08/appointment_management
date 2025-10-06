import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/login.dart';
import 'features/auth/presentation/screens/signup.dart';
import 'features/auth/presentation/screens/user_details_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/patient/presentation/screens/home.dart';
import 'features/doctor/presentation/screens/home.dart';
import 'features/admin/presentation/screens/home.dart';
import 'features/doctor/presentation/screens/all_doctors.dart';
import 'features/appointments/presentation/screens/appointment_details.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case 'signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case 'patient_home':
        return MaterialPageRoute(builder: (_) => const PatientHomeScreen());
      case 'doctor_home':
        return MaterialPageRoute(builder: (_) => const DoctorHomeScreen());
      case 'admin_home':
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      case 'all_doctors':
        return MaterialPageRoute(builder: (_) => const AllDoctorsScreen());
      case 'appointment_details':
        final appointment = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => AppointmentDetailsScreen(appointment: appointment),
        );
      case 'profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case 'user_details':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              UserDetailsScreen(user: args['user'], role: args['role']),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
