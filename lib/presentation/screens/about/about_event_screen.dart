import 'package:flutter/material.dart';
import '../../widgets/logo_ring_painter.dart';
import '../../widgets/highlight_icon.dart';

class AboutEventScreen extends StatelessWidget {
  const AboutEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'ABOUT EVENT',
          style: TextStyle(
              color: Color(0xFF125463),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF125463)),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // Header Logo & Text
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/seil_logo.png',
                height: 64,
              ),
              const SizedBox(width: 20),
              Container(width: 2, height: 70, color: const Color(0xFFE2E8F0)),
              const SizedBox(width: 20),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('C&I',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1B3B4B),
                            height: 1.0,
                            letterSpacing: -0.5)),
                    Text('CONNECT',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1B3B4B),
                            height: 1.0,
                            letterSpacing: -0.5)),
                    Text('2026',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF718E3E),
                            height: 1.0)),
                    SizedBox(height: 6),
                    Text('Hosted by SEIL Energy India Limited',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B3B4B))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Theme
          Row(
            children: [
              const Expanded(
                  child: Divider(color: Color(0xFFD4D4D4), thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('THEME',
                    style: TextStyle(
                        color: const Color(0xFF718E3E).withValues(alpha: 0.9),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2)),
              ),
              const Expanded(
                  child: Divider(color: Color(0xFFD4D4D4), thickness: 1)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Sustainable Solutions Through Advanced\nInstrumentation and Cyber-Resilient Control\nSystems in Thermal Power Plants',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                height: 1.5,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 32),

          // Date & Venue Box
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF718E3E), width: 1.5),
                color: Colors.white,
              ),
              child: const Column(
                children: [
                  Text('21st – 22nd May 2026',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1B3B4B))),
                  SizedBox(height: 8),
                  Divider(color: Color(0xFF718E3E), height: 1, thickness: 1),
                  SizedBox(height: 8),
                  Text('Hotel Minerva Grand, Nellore,\nAndhra Pradesh, India',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718E3E),
                          fontWeight: FontWeight.w600,
                          height: 1.4)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Key Highlights Header
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              color: const Color(0xFF718E3E),
              child: const Text('KEY HIGHLIGHTS',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0)),
            ),
          ),
          const SizedBox(height: 32),

          // Highlights Icons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 24,
            children: const [
              HighlightIcon(
                  icon: Icons.co_present_rounded, label: 'Keynote\nAddresses'),
              HighlightIcon(
                  icon: Icons.build_circle_rounded, label: 'Technical\nSessions'),
              HighlightIcon(
                  icon: Icons.factory_rounded,
                  label: 'Plant Visit & Live\nDemonstrations'),
              HighlightIcon(
                  icon: Icons.group_work_rounded, label: 'Expert\nNetworking'),
              HighlightIcon(
                  icon: Icons.handshake_rounded, label: 'Vendor\nCollaboration'),
            ],
          ),
          const SizedBox(height: 48),

          // Dividers for visual separation
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          const SizedBox(height: 24),

          // Focus Areas & Schedule (Responsive Layout)
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildFocusAreas()),
                    const SizedBox(width: 32),
                    Expanded(child: _buildTentativeSchedule()),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFocusAreas(),
                  const SizedBox(height: 32),
                  const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                  const SizedBox(height: 32),
                  _buildTentativeSchedule(),
                ],
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFocusAreas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FOCUS AREAS',
            style: TextStyle(
                color: Color(0xFF718E3E),
                fontWeight: FontWeight.w800,
                fontSize: 15,
                letterSpacing: 0.5)),
        const SizedBox(height: 16),
        _bulletText('Advanced DCS / PLC / SCADA & Digital Control Solutions'),
        _bulletText('Industrial IoT & Cybersecurity'),
        _bulletText('Predictive Maintenance & AI/ML'),
        _bulletText('Flexible Operations'),
        _bulletText('Implementation of AGC'),
        _bulletText('Environmental Compliance Strategy'),
        _bulletText('Best Maintenance Practices'),
      ],
    );
  }

  Widget _buildTentativeSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('',
            style: TextStyle(
                color: Color(0xFF718E3E),
                fontWeight: FontWeight.w800,
                fontSize: 15,
                letterSpacing: 0.5)),
        const SizedBox(height: 16),
        const Text('21st May 2026',
            style: TextStyle(
                color: Color(0xFF718E3E),
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        const SizedBox(height: 6),
        _bulletText('Registration & Inaugural Session'),
        _bulletText('Keynote Address'),
        _bulletText('Technical Sessions'),
        const SizedBox(height: 16),
        const Text('22nd May 2026',
            style: TextStyle(
                color: Color(0xFF718E3E),
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        const SizedBox(height: 6),
        _bulletText('Technical Sessions'),
        _bulletText('Valedictory Ceremony'),
        _bulletText('Plant Visit'),
      ],
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 10.0),
            child: CircleAvatar(radius: 2.5, backgroundColor: Color(0xFF1B3B4B)),
          ),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF333333), height: 1.4))),
        ],
      ),
    );
  }
}
