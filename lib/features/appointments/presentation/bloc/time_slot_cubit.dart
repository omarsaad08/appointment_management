import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/time_slot.dart';
import '../../data/repositories/time_slot_repository.dart';
import 'time_slot_state.dart';

class TimeSlotCubit extends Cubit<TimeSlotState> {
  final TimeSlotRepository _repository;

  TimeSlotCubit(this._repository) : super(const TimeSlotState());

  Future<void> loadTimeSlots(String doctorId, DateTime date) async {
    emit(state.copyWith(status: TimeSlotStatus.loading));

    try {
      final timeSlots = await _repository.getAvailableTimeSlots(doctorId, date);
      emit(
        state.copyWith(
          timeSlots: timeSlots,
          status: TimeSlotStatus.success,
          selectedDate: date,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TimeSlotStatus.error, error: e.toString()));
    }
  }

  void selectTimeSlot(TimeSlot timeSlot) {
    emit(state.copyWith(selectedTimeSlot: timeSlot));
  }

  Future<void> bookTimeSlot() async {
    if (state.selectedTimeSlot == null) return;

    emit(state.copyWith(status: TimeSlotStatus.loading));

    try {
      await _repository.bookTimeSlot(state.selectedTimeSlot!.id);
      emit(
        state.copyWith(
          status: TimeSlotStatus.success,
          timeSlots: state.timeSlots
              .map(
                (slot) => slot.id == state.selectedTimeSlot!.id
                    ? slot.copyWith(isAvailable: false)
                    : slot,
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TimeSlotStatus.error, error: e.toString()));
    }
  }

  void selectDate(DateTime date) {
    if (state.selectedDate?.year != date.year ||
        state.selectedDate?.month != date.month ||
        state.selectedDate?.day != date.day) {
      emit(state.copyWith(selectedDate: date, selectedTimeSlot: null));
    }
  }
}
