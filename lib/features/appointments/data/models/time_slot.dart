class TimeSlot {
  final String id;
  final String doctorId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isAvailable;

  TimeSlot({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
    };
  }

  TimeSlot copyWith({
    String? id,
    String? doctorId,
    DateTime? date,
    String? startTime,
    String? endTime,
    bool? isAvailable,
  }) {
    return TimeSlot(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
