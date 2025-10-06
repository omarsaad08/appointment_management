import 'package:equatable/equatable.dart';
import '../../data/models/time_slot.dart';

enum TimeSlotStatus { initial, loading, success, error }

class TimeSlotState extends Equatable {
  final List<TimeSlot> timeSlots;
  final TimeSlotStatus status;
  final String? error;
  final DateTime? selectedDate;
  final TimeSlot? selectedTimeSlot;

  const TimeSlotState({
    this.timeSlots = const [],
    this.status = TimeSlotStatus.initial,
    this.error,
    this.selectedDate,
    this.selectedTimeSlot,
  });

  TimeSlotState copyWith({
    List<TimeSlot>? timeSlots,
    TimeSlotStatus? status,
    String? error,
    DateTime? selectedDate,
    TimeSlot? selectedTimeSlot,
  }) {
    return TimeSlotState(
      timeSlots: timeSlots ?? this.timeSlots,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
    );
  }

  @override
  List<Object?> get props => [
    timeSlots,
    status,
    error,
    selectedDate,
    selectedTimeSlot,
  ];
}
