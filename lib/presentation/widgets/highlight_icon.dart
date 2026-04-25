import 'package:flutter/material.dart';

class HighlightIcon extends StatelessWidget {
  const HighlightIcon({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Icon(icon, size: 36, color: const Color(0xFF1B3B4B)),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
                height: 1.3),
          ),
        ],
      ),
    );
  }
}
