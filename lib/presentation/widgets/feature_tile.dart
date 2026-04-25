import 'package:flutter/material.dart';
import '../../data/models/feature_item.dart';

class FeatureTile extends StatelessWidget {
  const FeatureTile({super.key, required this.item, required this.onTap});

  final FeatureItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: item.color.withValues(alpha: 0.14),
                ),
                child: Icon(item.icon, color: item.color, size: 26),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
