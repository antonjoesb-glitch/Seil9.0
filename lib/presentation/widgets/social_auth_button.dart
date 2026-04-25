import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isTransparent = false,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isTransparent ? Colors.transparent : Colors.white.withValues(alpha: 0.05),
          side: BorderSide(
            color: Colors.white.withValues(alpha: isTransparent ? 0.2 : 0.1),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
