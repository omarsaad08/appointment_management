import 'package:flutter/material.dart';
import '../../data/models/time_slot.dart';

class TimeSlotCard extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      child: InkWell(
        onTap: timeSlot.isAvailable ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${timeSlot.startTime} - ${timeSlot.endTime}',
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : timeSlot.isAvailable
                      ? Colors.black
                      : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (!timeSlot.isAvailable)
                const Text(
                  'Booked',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
