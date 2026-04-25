import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('HELP',
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
            'HELP:',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: Color(0xFF125463),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'For all queries:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          _buildContactRow(
            name: 'Madhava Rao Bitra',
            role: 'Head- C&I',
            phone: '7032967426',
            email: 'madhav.bitra@seilenergy.com',
          ),
          const SizedBox(height: 20),
          _buildContactRow(
            name: 'Ramesh Kode',
            role: 'AGM- C&I',
            phone: '8978681187',
            email: 'ramesh.kode@seilenergy.com',
          ),
          const SizedBox(height: 20),
          _buildContactRow(
            name: 'Venkata Krishna Vemulapalli',
            role: 'AGM- C&I',
            phone: '7093980323',
            email: 'venkata.vemulapalli@seilenergy.com',
          ),
          const SizedBox(height: 20),
          _buildContactRow(
            name: 'Mohan Reddy Nalladi',
            role: 'AGM-C&I',
            phone: '9963479754',
            email: 'mohan.nalladi@seilenergy.com',
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required String name,
    required String role,
    required String phone,
    required String email,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(role,
              style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              final url = Uri.parse('tel:$phone');
              try {
                await launchUrl(url);
              } catch (e) {
                debugPrint('Could not launch $url: $e');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.phone_outlined,
                      size: 18, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Text('Ph: $phone',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A90E2),
                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () async {
              final url = Uri.parse('mailto:$email');
              try {
                await launchUrl(url);
              } catch (e) {
                debugPrint('Could not launch $url: $e');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined,
                      size: 18, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(email,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4A90E2),
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
