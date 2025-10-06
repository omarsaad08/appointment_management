class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final String status;
  final String type;
  final String notes;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.status,
    required this.type,
    required this.notes,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      status: json['status'] as String,
      type: json['type'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'type': type,
      'notes': notes,
    };
  }
}
