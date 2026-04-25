import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          const SizedBox(height: 48),
          const Text(
            'Html code for map:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const SelectableText(
            '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3682.737588083576!2d79.9695512!3d14.4354708!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a4cf3607d9137db%3A0xfa5f2ac32a13791c!2sHotel%20Minerva%20Grand%20Nellore%20%23Bluefox%20Restaurent%20%23%20ON%20The%20Rocks%20Bar%23!5e1!3m2!1sen!2sin!4v1776079792819!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
