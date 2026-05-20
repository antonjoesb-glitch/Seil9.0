import 'package:flutter/material.dart';

enum EventType { normal, breakType, sectionHeader }

class ScheduleEvent {
  final String title;
  final String? subtitle;
  final String time;
  final IconData? icon;
  final EventType type;
  final Color? color;

  const ScheduleEvent({
    required this.title,
    this.subtitle,
    required this.time,
    this.icon,
    this.type = EventType.normal,
    this.color,
  });
}

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  int selectedDay = 2; // Defaulting to Day 2 for testing, wait, no, default should be 1. Let me set it to 1.
  
  @override
  void initState() {
    super.initState();
    selectedDay = 1;
  }

  final List<ScheduleEvent> day1Events = const [
    // DETAILED PROGRAM PLAN
    ScheduleEvent(title: 'DETAILED PROGRAM PLAN', time: '', type: EventType.sectionHeader),
    ScheduleEvent(title: 'Registration', time: '09:30 AM – 10:00 AM', icon: Icons.app_registration),
    ScheduleEvent(title: 'Assembling at venue', time: '10:00 AM – 10:15 AM', icon: Icons.groups),
    ScheduleEvent(title: 'Welcome to Dignitaries & Lamp Lighting', time: '10:15 AM – 10:25 AM', icon: Icons.lightbulb_outline),
    ScheduleEvent(title: 'Safety Briefing by HSE', time: '10:25 AM – 10:28 AM', icon: Icons.health_and_safety_outlined),
    ScheduleEvent(title: 'SEIL Overview AV with SEIL Anthem', time: '10:28 AM – 10:40 AM', icon: Icons.play_circle_outline),
    ScheduleEvent(title: 'Welcome Address', time: '10:40 AM – 10:45 AM', icon: Icons.mic_external_on_outlined),
    ScheduleEvent(title: 'Inaugural speech', time: '10:45 AM – 10:55 AM', icon: Icons.record_voice_over_outlined),
    ScheduleEvent(title: 'Special address by guest of honor', subtitle: 'Inauguration of SEIL Best Practices - Journal', time: '10:55 AM – 11:10 AM', icon: Icons.star_border),
    
    // TEA BREAK
    ScheduleEvent(title: 'TEA BREAK', time: '11:10 AM to 11:20 AM', icon: Icons.local_cafe, type: EventType.breakType, color: Color(0xFFD84315)),
    
    // TECHNICAL SESSION I
    ScheduleEvent(title: 'TECHNICAL SESSION – I', time: '', type: EventType.sectionHeader),
    ScheduleEvent(title: 'Paper presentation by IL & FS', subtitle: 'Topic: Industry-4.0 and Best maintenance practices', time: '11:20 AM – 11:35 AM', icon: Icons.settings_suggest_outlined),
    ScheduleEvent(title: 'Presentation by SEIL', subtitle: 'Topic: Cyber security initiatives taken by SEIL for OT Environment', time: '11:35 AM – 11:50 AM', icon: Icons.security_outlined),
    ScheduleEvent(title: 'Paper Presentation by SDSTPL – AP Genco', subtitle: 'Topic: Best practices in C&I', time: '11:50 AM – 12:05 PM', icon: Icons.factory_outlined),
    ScheduleEvent(title: 'Paper Presentation by SIEMENS Energy', subtitle: 'Topic: Flexible Operation through APC', time: '12:05 PM – 12:25 PM', icon: Icons.speed_outlined),
    ScheduleEvent(title: 'Paper Presentation by BTPS', subtitle: 'Topic: AI & ML based coal GCV and Load prediction system', time: '12:25 PM – 12:40 PM', icon: Icons.memory_outlined),
    ScheduleEvent(title: 'Paper Presentation by JSW Energy', subtitle: 'Topic: Best practices – C&I', time: '12:40 PM – 12:55 PM', icon: Icons.domain),
    ScheduleEvent(title: 'Technical Session – I Q & A Session', time: '12:55 PM – 01:10 PM', icon: Icons.help_outline),
    
    // LUNCH BREAK
    ScheduleEvent(title: 'LUNCH BREAK', time: '01:15 PM to 02:15 PM', icon: Icons.restaurant, type: EventType.breakType, color: Color(0xFF2E7D32)),
    
    // FREE WHEELING DISCUSSION
    ScheduleEvent(title: 'FREE WHEELING DISCUSSION', time: '02:15 PM – 03:45 PM', icon: Icons.forum_outlined, type: EventType.breakType, color: Color(0xFF6A1B9A)),
    
    // TEA BREAK
    ScheduleEvent(title: 'TEA BREAK', time: '03:45 PM to 04:00 PM', icon: Icons.local_cafe, type: EventType.breakType, color: Color(0xFFD84315)),
    
    ScheduleEvent(title: 'Presentation by EIP Enviro controls', subtitle: 'Topic: Modern day Ash level measurement', time: '04:00 PM – 04:15 PM', icon: Icons.factory_outlined),
    ScheduleEvent(title: 'Presentation by NTPS – Station-2', subtitle: 'Topic: OT Cyber security', time: '04:15 PM – 04:30 PM', icon: Icons.security_outlined),
    ScheduleEvent(title: 'Presentation by Schneider electric', subtitle: 'Topic: Secured control system', time: '04:30 PM – 04:50 PM', icon: Icons.verified_user_outlined),
    ScheduleEvent(title: 'Presentation by SEIL-OS Team', subtitle: 'On SEIL-Digital Tools', time: '04:50 PM – 05:05 PM', icon: Icons.desktop_windows_outlined),
    ScheduleEvent(title: 'Presentation by Forbes marshal', subtitle: 'Topic: CEMS', time: '05:15 PM – 05:35 PM', icon: Icons.speed_outlined),
    ScheduleEvent(title: 'Day-1 Conclusion & Next Day Schedule Brief', time: '05:35 PM – 06:00 PM', icon: Icons.event_available_outlined),
    
    // DINNER
    ScheduleEvent(title: 'DINNER', time: '07:30 PM to 09:30 PM', icon: Icons.dinner_dining, type: EventType.breakType, color: Color(0xFF1565C0)),
  ];

  final List<ScheduleEvent> day2Events = const [
    // DETAILED PROGRAM PLAN
    ScheduleEvent(title: 'DETAILED PROGRAM PLAN', time: '', type: EventType.sectionHeader),
    ScheduleEvent(title: 'Assembling at venue', time: '09:50 AM – 10:00 AM', icon: Icons.groups),
    
    // TECHNICAL SESSION II
    ScheduleEvent(title: 'TECHNICAL SESSION – II', time: '', type: EventType.sectionHeader),
    ScheduleEvent(title: 'Paper Presentation by Vedanta Power – Meenakshi Energy', time: '10:00 AM – 10:15 AM', icon: Icons.factory_outlined),
    ScheduleEvent(title: 'Paper Presentation – SEIL', subtitle: 'Topic: SEIL C&I Best Practices', time: '10:15 AM – 10:30 AM', icon: Icons.cloud_outlined),
    ScheduleEvent(title: 'Presentation by Jaaji technologies', subtitle: 'Topic: Increase Operating Efficiency with Connected-worker', time: '10:30 AM – 10:45 AM', icon: Icons.engineering_outlined),
    ScheduleEvent(title: 'Technical Session – II Q & A Session', time: '10:45 AM – 11:00 AM', icon: Icons.forum_outlined),
    
    // TEA BREAK
    ScheduleEvent(title: 'TEA BREAK', time: '11:00 AM to 11:15 AM', icon: Icons.local_cafe, type: EventType.breakType, color: Color(0xFFD84315)),
    
    ScheduleEvent(title: 'Paper Presentation – by Moxie power generation', subtitle: 'Topic: C&I Best practices', time: '11:15 AM – 11:30 AM', icon: Icons.bolt_outlined),
    ScheduleEvent(title: 'Presentation by Rockwell Automation', subtitle: 'Topic: AI Augmented Production system', time: '11:30 AM – 11:45 AM', icon: Icons.wifi_tethering_outlined),
    ScheduleEvent(title: 'Presentation by Micro Business Solutions', subtitle: 'Topic: AI Based CCTV System', time: '11:45 AM – 12:00 PM', icon: Icons.videocam_outlined),
    
    // AWARDS DISTRIBUTION
    ScheduleEvent(title: 'AWARDS DISTRIBUTION', time: '12:00 PM to 12:40 PM', icon: Icons.emoji_events_outlined, type: EventType.breakType, color: Color(0xFF6A1B9A)),
    
    // VALEDICTORY FUNCTION & VOTE OF THANKS
    ScheduleEvent(title: 'VALEDICTORY FUNCTION & VOTE OF THANKS', time: '12:40 PM to 01:00 PM', icon: Icons.handshake_outlined, type: EventType.breakType, color: Color(0xFF0D47A1)),
    
    // LUNCH BREAK
    ScheduleEvent(title: 'LUNCH BREAK', time: '01:00 PM to 02:00 PM', icon: Icons.restaurant, type: EventType.breakType, color: Color(0xFF2E7D32)),
    
    // PLANT VISIT
    ScheduleEvent(title: 'PLANT VISIT', time: '', type: EventType.sectionHeader),
    ScheduleEvent(title: 'Drive to Plant – 2', time: '02:15 PM – 03:00 PM', icon: Icons.directions_bus_outlined),
    ScheduleEvent(title: 'Safety Brief & PPE Distribution', time: '03:00 PM – 03:20 PM', icon: Icons.health_and_safety_outlined),
    ScheduleEvent(title: 'P2 Plant Visit', time: '03:20 PM – 04:30 PM', icon: Icons.factory_outlined),
    ScheduleEvent(title: 'Drive to Plant – 1 @ Buddha Garden', time: '04:30 PM – 04:45 PM', icon: Icons.directions_bus_outlined),
    
    // CLOSING CEREMONY
    ScheduleEvent(title: 'CLOSING CEREMONY @ BUDDHA GARDEN WITH HIGH TEA', time: '04:45 PM to 05:30 PM', icon: Icons.emoji_food_beverage_outlined, type: EventType.breakType, color: Color(0xFF1B5E20)),
    
    // Drive to Venue from Plant - 1
    ScheduleEvent(title: 'Drive to Venue from Plant – 1', time: '05:30 PM – 06:30 PM', icon: Icons.directions_bus_filled_outlined, type: EventType.breakType, color: Color(0xFF1A237E)),
    
    // END OF EVENT
    ScheduleEvent(title: '★ END OF THE EVENT ★', subtitle: 'Thank You!', time: '', type: EventType.sectionHeader, color: Colors.transparent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          'EVENT CALENDAR',
          style: TextStyle(
            color: Color(0xFF1B3B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1B3B4B)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildDayButton(
                    day: 1, 
                    title: 'Day 1', 
                    date: '21st May 2026',
                    isSelected: selectedDay == 1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDayButton(
                    day: 2, 
                    title: 'Day 2', 
                    date: '22nd May 2026',
                    isSelected: selectedDay == 2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildScheduleList(selectedDay == 1 ? day1Events : day2Events),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton({required int day, required String title, required String date, required bool isSelected}) {
    return InkWell(
      onTap: () => setState(() => selectedDay = day),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B1FA2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF7B1FA2) : const Color(0xFFE2E8F0),
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF7B1FA2).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white70 : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList(List<ScheduleEvent> events) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        switch (event.type) {
          case EventType.sectionHeader:
            return _buildSectionHeader(event);
          case EventType.breakType:
            return _buildBreakBanner(event);
          case EventType.normal:
            return _buildNormalEvent(event);
        }
      },
    );
  }

  Widget _buildSectionHeader(ScheduleEvent event) {
    bool isTransparent = event.color == Colors.transparent;
    
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: event.color ?? const Color(0xFF880E4F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              event.title,
              style: TextStyle(
                fontSize: isTransparent ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: isTransparent ? const Color(0xFF1E293B) : Colors.white,
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            if (event.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                event.subtitle!,
                style: TextStyle(
                  fontSize: isTransparent ? 18 : 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: isTransparent ? FontWeight.bold : FontWeight.normal,
                  color: isTransparent ? const Color(0xFF0F766E) : Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBreakBanner(ScheduleEvent event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: event.color ?? const Color(0xFFE65100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (event.color ?? const Color(0xFFE65100)).withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            if (event.icon != null) ...[
              Icon(event.icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                event.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalEvent(ScheduleEvent event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(
                event.icon ?? Icons.event_outlined,
                color: const Color(0xFF1E3A8A),
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.time,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      height: 1.3,
                    ),
                  ),
                  if (event.subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      event.subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F766E),
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
