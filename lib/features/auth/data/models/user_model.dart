// lib/core/enums/user_role.dart
enum UserRole {
  patient,
  doctor,
  admin;

  String get value {
    switch (this) {
      case UserRole.patient:
        return 'patient';
      case UserRole.doctor:
        return 'doctor';
      case UserRole.admin:
        return 'admin';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'patient':
        return UserRole.patient;
      case 'doctor':
        return UserRole.doctor;
      case 'admin':
        return UserRole.admin;
      default:
        throw Exception('Invalid user role: $role');
    }
  }
}

// ============================================
// lib/features/auth/data/models/user_model.dart
// ============================================

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final UserRole role;
  final String? profileImage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Role-specific data (will be populated based on role)
  final PatientModel? patientData;
  final DoctorModel? doctorData;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.profileImage,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.patientData,
    this.doctorData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final role = UserRole.fromString(json['role']);

    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: role,
      profileImage: json['profile_image'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      // Parse role-specific data if included
      patientData: role == UserRole.patient && json['patient_data'] != null
          ? PatientModel.fromJson(json['patient_data'])
          : null,
      doctorData: role == UserRole.doctor && json['doctor_data'] != null
          ? DoctorModel.fromJson(json['doctor_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role': role.value,
      'profile_image': profileImage,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      if (patientData != null) 'patient_data': patientData!.toJson(),
      if (doctorData != null) 'doctor_data': doctorData!.toJson(),
    };
  }

  // Helper methods
  bool get isPatient => role == UserRole.patient;
  bool get isDoctor => role == UserRole.doctor;
  bool get isAdmin => role == UserRole.admin;

  // Copy with method for updates
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    UserRole? role,
    String? profileImage,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    PatientModel? patientData,
    DoctorModel? doctorData,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      patientData: patientData ?? this.patientData,
      doctorData: doctorData ?? this.doctorData,
    );
  }
}

// ============================================
// lib/features/patients/data/models/patient_model.dart
// ============================================

class PatientModel {
  final int id;
  final int userId; // Foreign key to users table
  final DateTime? dateOfBirth;
  final String? gender;
  final String? bloodType;
  final String? address;
  final String? emergencyContact;
  final String? emergencyContactPhone;
  final List<String>? allergies;
  final List<String>? chronicDiseases;
  final String? insuranceNumber;
  final DateTime createdAt;
  final DateTime? updatedAt;

  PatientModel({
    required this.id,
    required this.userId,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
    this.address,
    this.emergencyContact,
    this.emergencyContactPhone,
    this.allergies,
    this.chronicDiseases,
    this.insuranceNumber,
    required this.createdAt,
    this.updatedAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      userId: json['user_id'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      gender: json['gender'],
      bloodType: json['blood_type'],
      address: json['address'],
      emergencyContact: json['emergency_contact'],
      emergencyContactPhone: json['emergency_contact_phone'],
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : null,
      chronicDiseases: json['chronic_diseases'] != null
          ? List<String>.from(json['chronic_diseases'])
          : null,
      insuranceNumber: json['insurance_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'blood_type': bloodType,
      'address': address,
      'emergency_contact': emergencyContact,
      'emergency_contact_phone': emergencyContactPhone,
      'allergies': allergies,
      'chronic_diseases': chronicDiseases,
      'insurance_number': insuranceNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Calculate age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  PatientModel copyWith({
    int? id,
    int? userId,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? emergencyContact,
    String? emergencyContactPhone,
    List<String>? allergies,
    List<String>? chronicDiseases,
    String? insuranceNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      allergies: allergies ?? this.allergies,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// ============================================
// lib/features/doctors/data/models/doctor_model.dart
// ============================================

class DoctorModel {
  final int id;
  final int userId; // Foreign key to users table
  final String specialization;
  final String? licenseNumber;
  final int yearsOfExperience;
  final String? qualifications;
  final String? biography;
  final double consultationFee;
  final double rating;
  final int totalReviews;
  final List<String>? availableDays; // e.g., ['monday', 'tuesday', 'wednesday']
  final String? clinicAddress;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DoctorModel({
    required this.id,
    required this.userId,
    required this.specialization,
    this.licenseNumber,
    required this.yearsOfExperience,
    this.qualifications,
    this.biography,
    required this.consultationFee,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.availableDays,
    this.clinicAddress,
    this.isAvailable = true,
    required this.createdAt,
    this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      userId: json['user_id'],
      specialization: json['specialization'],
      licenseNumber: json['license_number'],
      yearsOfExperience: json['years_of_experience'] ?? 0,
      qualifications: json['qualifications'],
      biography: json['biography'],
      consultationFee: (json['consultation_fee'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      availableDays: json['available_days'] != null
          ? List<String>.from(json['available_days'])
          : null,
      clinicAddress: json['clinic_address'],
      isAvailable: json['is_available'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'specialization': specialization,
      'license_number': licenseNumber,
      'years_of_experience': yearsOfExperience,
      'qualifications': qualifications,
      'biography': biography,
      'consultation_fee': consultationFee,
      'rating': rating,
      'total_reviews': totalReviews,
      'available_days': availableDays,
      'clinic_address': clinicAddress,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Helper to check if doctor works on a specific day
  bool isAvailableOnDay(String day) {
    if (availableDays == null) return false;
    return availableDays!.contains(day.toLowerCase());
  }

  DoctorModel copyWith({
    int? id,
    int? userId,
    String? specialization,
    String? licenseNumber,
    int? yearsOfExperience,
    String? qualifications,
    String? biography,
    double? consultationFee,
    double? rating,
    int? totalReviews,
    List<String>? availableDays,
    String? clinicAddress,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      specialization: specialization ?? this.specialization,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      qualifications: qualifications ?? this.qualifications,
      biography: biography ?? this.biography,
      consultationFee: consultationFee ?? this.consultationFee,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      availableDays: availableDays ?? this.availableDays,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// ============================================
// lib/features/admin/data/models/admin_model.dart
// ============================================

// class AdminModel {
//   final int id;
//   final int userId; // Foreign key to users table
//   final String? permissions; // JSON string or comma-separated permissions
//   final DateTime createdAt;
//   final DateTime? updatedAt;

//   AdminModel({
//     required this.id,
//     required this.userId,
//     this.permissions,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   factory AdminModel.fromJson(Map<String, dynamic> json) {
//     return AdminModel(
//       id: json['id'],
//       userId: json['user_id'],
//       permissions: json['permissions'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'permissions': permissions,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }

//   AdminModel copyWith({
//     int? id,
//     int? userId,
//     String? permissions,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return AdminModel(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       permissions: permissions ?? this.permissions,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }
