import 'package:flutter/material.dart';

class LogoRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;

    // Draw the green background crescent
    final bgPaint = Paint()
      ..color = const Color(0xFF6A8E3C) // Match the true green logo color
      ..style = PaintingStyle.fill;

    // Combine outer circle and offset inner circle
    final outerPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: outerRadius));

    // Offset the inner circle to the right to make the left side thick and right side thin
    final innerCenter = Offset(center.dx + size.width * 0.12, center.dy);
    final innerRadius = size.width * 0.35;
    final innerPath = Path()
      ..addOval(Rect.fromCircle(center: innerCenter, radius: innerRadius));

    final crescentPath =
        Path.combine(PathOperation.difference, outerPath, innerPath);

    // We clip to the crescent so white lines don't leak out of the circle bounds
    canvas.save();
    canvas.clipPath(crescentPath);

    // Draw the full circle fill
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Draw the slanted white cuts
    final cutPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Create ~16 diagonal slashes radiating around
    for (int i = 0; i < 20; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      // Rotate around the center
      canvas.rotate((i * 18) * 3.14159 / 180);
      // Draw slanted line across the ring section
      // By drawing off-axis, they form a nice slanted twist across the ring
      canvas.drawLine(Offset(innerRadius * 0.5, outerRadius * 0.25),
          Offset(outerRadius * 1.5, -outerRadius * 0.25), cutPaint);
      canvas.restore();
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
