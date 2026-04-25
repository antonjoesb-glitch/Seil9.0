import 'package:flutter/material.dart';

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
