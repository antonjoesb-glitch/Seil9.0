import 'package:flutter/material.dart';
import '../../data/models/feature_item.dart';

class SpecialFeatureCard extends StatelessWidget {
  const SpecialFeatureCard({super.key, required this.item});

  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                if (item.subtitle != null)
                  Text(
                    item.subtitle!,
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
