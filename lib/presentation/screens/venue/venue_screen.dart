import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'venue_map.dart';

class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('VENUE',
            style: TextStyle(
                color: Color(0xFF1B3B4B),
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B3B4B)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'VENUE:',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: Color(0xFF125463),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hotel Minerva Grand, Saraswathi Nagar, Dargamitta,\nNellore, Andhra Pradesh 524003',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Google maps link:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final url = Uri.parse('https://maps.app.goo.gl/Hx5Razwr67F7du3N9');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                debugPrint('Could not launch $url');
              }
            },
            child: const Text(
              'https://maps.app.goo.gl/Hx5Razwr67F7du3N9',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB06F8C), // Similar to image
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFB06F8C),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Live Map:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const VenueMap(),
        ],
      ),
    );
  }
}
