import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/time_slot.dart';

class TimeSlotRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'timeSlots';

  TimeSlotRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<TimeSlot>> getAvailableTimeSlots(
    String doctorId,
    DateTime date,
  ) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('doctorId', isEqualTo: doctorId)
          .where(
            'date',
            isEqualTo: DateTime(
              date.year,
              date.month,
              date.day,
            ).toIso8601String(),
          )
          .where('isAvailable', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => TimeSlot.fromJson(doc.data()..['id'] = doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get available time slots: $e');
    }
  }

  Future<void> bookTimeSlot(String timeSlotId) async {
    try {
      await _firestore.collection(_collection).doc(timeSlotId).update({
        'isAvailable': false,
      });
    } catch (e) {
      throw Exception('Failed to book time slot: $e');
    }
  }

  Future<List<TimeSlot>> getDoctorTimeSlots(String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('doctorId', isEqualTo: doctorId)
          .get();

      return snapshot.docs
          .map((doc) => TimeSlot.fromJson(doc.data()..['id'] = doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get doctor time slots: $e');
    }
  }

  Future<void> createTimeSlot(TimeSlot timeSlot) async {
    try {
      await _firestore.collection(_collection).add(timeSlot.toJson());
    } catch (e) {
      throw Exception('Failed to create time slot: $e');
    }
  }

  Future<void> createBulkTimeSlots(List<TimeSlot> timeSlots) async {
    try {
      final batch = _firestore.batch();
      for (var timeSlot in timeSlots) {
        final docRef = _firestore.collection(_collection).doc();
        batch.set(docRef, timeSlot.toJson());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to create bulk time slots: $e');
    }
  }

  Future<void> deleteTimeSlot(String timeSlotId) async {
    try {
      await _firestore.collection(_collection).doc(timeSlotId).delete();
    } catch (e) {
      throw Exception('Failed to delete time slot: $e');
    }
  }
}
