import 'package:flutter/material.dart';

class MedicalIcon extends StatelessWidget {
  final double size;
  final Color color;

  const MedicalIcon({
    super.key,
    this.size = 24,
    this.color = const Color(0xFF3B82F6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: Icon(
        Icons.medical_services_rounded,
        size: size * 0.6,
        color: color,
      ),
    );
  }
}
