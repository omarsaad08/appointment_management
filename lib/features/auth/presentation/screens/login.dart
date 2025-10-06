import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/medical_icon.dart';
import '../../../../core/config/theme_config.dart';
import '../../../../core/utils/validators/input_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Role-based routing
      String route = _getRouteForUser(
        _emailController.text,
        _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, route);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: AppTheme.success,
        ),
      );
    }
  }

  String _getRouteForUser(String email, String password) {
    // Role-based routing logic
    if (email == 'patient@gmail.com' && password == 'patient@gmail.com') {
      return 'patient_home';
    } else if (email == 'doctor@gmail.com' && password == 'doctor@gmail.com') {
      return 'doctor_home';
    } else if (email == 'admin@gmail.com' && password == 'admin@gmail.com') {
      return 'admin_home';
    } else {
      // Default to patient home for any other credentials
      return 'patient_home';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.patientBackground,
              AppTheme.cardBlue,
              AppTheme.cardGreen,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 40
                    : isTablet
                    ? 32
                    : 24,
                vertical: 32,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop
                      ? 500
                      : isTablet
                      ? 400
                      : double.infinity,
                ),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundCard,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(
                      isDesktop
                          ? 48
                          : isTablet
                          ? 40
                          : 32,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo and Title
                          Column(
                            children: [
                              const MedicalIcon(size: 64),
                              const SizedBox(height: 24),
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.inter(
                                  fontSize: isDesktop ? 32 : 28,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF111827),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in to your medical account',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: const Color(0xFF6B7280),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Email Field
                          CustomTextField(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            icon: Icons.email_outlined,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: InputValidators.validateEmail,
                          ),
                          const SizedBox(height: 24),

                          // Password Field
                          CustomTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            icon: Icons.lock_outline,
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            validator: InputValidators.validatePassword,
                          ),
                          const SizedBox(height: 16),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Forgot password feature coming soon!',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.patientPrimary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Login Button
                          CustomButton(
                            text: 'Sign In',
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 24),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'signup',
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.patientPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
