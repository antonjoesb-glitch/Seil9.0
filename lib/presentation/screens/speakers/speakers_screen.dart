import 'package:flutter/material.dart';

class Speaker {
  final String name;
  final String topic;
  final String plant;

  const Speaker({
    required this.name,
    required this.topic,
    required this.plant,
  });
}

class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({super.key});

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  final List<Speaker> speakers = const [
    Speaker(
      name: 'Mr. L Stephen Miller',
      topic: 'Industry 4.0 Best practices',
      plant: 'IL&FS Tamil Nadu Power Company Ltd-Cuddalore',
    ),
    Speaker(
      name: 'Mr. B.Vidya sagar',
      topic: 'Best Practices in C&I',
      plant: 'SDSTPL-AP Genco-Nellore',
    ),
    Speaker(
      name: 'Mr. Ananth Atyam',
      topic: 'OT Cyber security',
      plant: 'SEIL Energy india limited',
    ),
    Speaker(
      name: 'Mr. Umang Swaroop',
      topic: 'Flexible operation through APC',
      plant: 'SIEMENS Energy india Limited',
    ),
    Speaker(
      name: 'Mr. Sreenivas V S',
      topic: 'An Intelligent Thermal power plant operational Decision support system',
      plant: 'Bellary Thermal Power Station/KPCLKudatini',
    ),
    Speaker(
      name: 'Mr. Biswajit sahu',
      topic: 'Best Practices in C&I',
      plant: 'JSW Energy limited -Toranagallu',
    ),
    Speaker(
      name: 'Mr. Abhishek goyal',
      topic: 'Modern day ash level measurement',
      plant: 'EIP Enviro controls',
    ),
    Speaker(
      name: 'Mr. V.A.Karthick',
      topic: 'Operational Technology Security in Critical Infrastructure',
      plant: 'NLC Tamilnadu Power limited (NTPL)',
    ),
    Speaker(
      name: 'Mr. Abhay Thodge',
      topic: 'Secured control systems',
      plant: 'Schneider Electric',
    ),
    Speaker(
      name: 'Mr. Chiranjeevi & Mr. Shivaram',
      topic: 'SEIL Digital tools',
      plant: 'SEIL Energy india limited',
    ),
    Speaker(
      name: 'Mr. Aditya kanetkar',
      topic: 'Moderen CEMS',
      plant: 'Forbes Marshall',
    ),
    Speaker(
      name: 'Mr. Gopi Krishna',
      topic: 'CMC A new approach,stable operation with widely varying coal',
      plant: 'Kothagudem Thermal power station-Stage-1',
    ),
    Speaker(
      name: 'Mr. Dinesh Singh & Mr.Shankar B',
      topic: 'Best Practices in C&I',
      plant: 'SEIL Energy india limited',
    ),
    Speaker(
      name: 'Mr. Siva Rama Brahmam',
      topic: 'Increase operating effeciency with connected worker',
      plant: 'Jaaji technilogies',
    ),
    Speaker(
      name: 'Mr. Yogaraj D',
      topic: 'Best Practices in C&I',
      plant: 'Moxie Power Generation Limited-Tuticorin',
    ),
    Speaker(
      name: 'Mr. Narendranath',
      topic: 'AI Augemented production system',
      plant: 'Rockwell Automation',
    ),
    Speaker(
      name: 'Mr. Shubham gupta',
      topic: 'AI Based CCTV system',
      plant: 'Micro Business solutions',
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Speaker> _getFilteredSpeakers() {
    if (searchQuery.trim().isEmpty) return speakers;
    final query = searchQuery.toLowerCase();
    return speakers.where((speaker) {
      return speaker.name.toLowerCase().contains(query) ||
          speaker.topic.toLowerCase().contains(query) ||
          speaker.plant.toLowerCase().contains(query);
    }).toList();
  }

  String _getInitials(String name) {
    // Remove salutations
    String cleanName = name
        .replaceAll(RegExp(r'^(Mr\.|Ms\.|Dr\.|Mrs\.)\s*', caseSensitive: false), '')
        .trim();
    
    // Handle double speaker format (e.g. Mr. Chiranjeevi & Mr. Shivaram)
    if (cleanName.contains('&')) {
      List<String> coSpeakers = cleanName.split('&');
      if (coSpeakers.length >= 2) {
        String s1 = coSpeakers[0].trim();
        String s2 = coSpeakers[1].trim().replaceAll(RegExp(r'^(Mr\.|Ms\.|Dr\.|Mrs\.)\s*', caseSensitive: false), '').trim();
        return (s1.isNotEmpty ? s1[0] : '') + (s2.isNotEmpty ? s2[0] : '');
      }
    }

    List<String> parts = cleanName.split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSpeakers = _getFilteredSpeakers();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          'SPEAKERS',
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
          // Search Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: TextField(
              controller: searchController,
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search speakers, topics, or plants...',
                hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: Color(0xFF64748B)),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF9A62FF), width: 1.5),
                ),
              ),
            ),
          ),
          
          // Speakers List
          Expanded(
            child: filteredSpeakers.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: const Color(0xFF94A3B8).withOpacity(0.6),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No Speakers Found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We couldn\'t find any speakers or topics matching "$searchQuery".',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    itemCount: filteredSpeakers.length,
                    itemBuilder: (context, index) {
                      final speaker = filteredSpeakers[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.04),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Speaker Avatar / Initials
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF9A62FF),
                                              Color(0xFF8E5CFF),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF9A62FF).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          _getInitials(speaker.name),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      
                                      // Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              speaker.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            
                                            // Topic Section
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8FAFC),
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: const Color(0xFFF1F5F9),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.slideshow_rounded,
                                                    size: 18,
                                                    color: Color(0xFF9A62FF),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      speaker.topic,
                                                      style: const TextStyle(
                                                        fontSize: 13.5,
                                                        color: Color(0xFF475569),
                                                        fontWeight: FontWeight.w600,
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            
                                            // Plant badge
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.business_outlined,
                                                  size: 14,
                                                  color: Color(0xFF64748B),
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    speaker.plant,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF64748B),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
