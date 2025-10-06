class Patient {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final List<String> appointments;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.appointments,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String,
      appointments: List<String>.from(json['appointments'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'appointments': appointments,
    };
  }
}
