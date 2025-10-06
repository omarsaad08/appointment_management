class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final List<String> appointments;
  final double rating;
  final int patientsCount;
  final int experienceYears;
  final String about;
  final List<String> availableDays;
  final List<String> languages;
  final String qualifications;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.appointments,
    required this.rating,
    required this.patientsCount,
    required this.experienceYears,
    required this.about,
    required this.availableDays,
    required this.languages,
    required this.qualifications,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String,
      appointments: List<String>.from(json['appointments'] as List),
      rating: (json['rating'] as num).toDouble(),
      patientsCount: json['patientsCount'] as int,
      experienceYears: json['experienceYears'] as int,
      about: json['about'] as String,
      availableDays: List<String>.from(json['availableDays'] as List),
      languages: List<String>.from(json['languages'] as List),
      qualifications: json['qualifications'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'appointments': appointments,
      'rating': rating,
      'patientsCount': patientsCount,
      'experienceYears': experienceYears,
      'about': about,
      'availableDays': availableDays,
      'languages': languages,
      'qualifications': qualifications,
    };
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? specialization,
    String? email,
    String? phoneNumber,
    String? profileImage,
    List<String>? appointments,
    double? rating,
    int? patientsCount,
    int? experienceYears,
    String? about,
    List<String>? availableDays,
    List<String>? languages,
    String? qualifications,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      appointments: appointments ?? this.appointments,
      rating: rating ?? this.rating,
      patientsCount: patientsCount ?? this.patientsCount,
      experienceYears: experienceYears ?? this.experienceYears,
      about: about ?? this.about,
      availableDays: availableDays ?? this.availableDays,
      languages: languages ?? this.languages,
      qualifications: qualifications ?? this.qualifications,
    );
  }
}
