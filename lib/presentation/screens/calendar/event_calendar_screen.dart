import 'package:flutter/material.dart';

class EventCalendarScreen extends StatelessWidget {
  const EventCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Event Calendar',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w400)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TENTATIVE SCHEDULE',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8E23), // Olive Green
              ),
            ),
            const SizedBox(height: 24),

            // 21st May
            const Text(
              '21st May 2026',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8E23),
              ),
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('Registration & Inaugural Session'),
            _buildBulletPoint('Keynote Address'),
            _buildBulletPoint('Technical Sessions'),

            const SizedBox(height: 32),

            // 22nd May
            const Text(
              '22nd May 2026',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8E23),
              ),
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('Technical Sessions'),
            _buildBulletPoint('Valedictory Ceremony'),
            _buildBulletPoint('Plant Visit'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style:
                TextStyle(fontSize: 18, color: Color(0xFF1E3A5F), height: 1.2), // Dark Blue
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 16, color: Color(0xFF1E3A5F), height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
