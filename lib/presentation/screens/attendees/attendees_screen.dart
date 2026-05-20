import 'package:flutter/material.dart';

class Attendee {
  final String name;
  final String designation;

  const Attendee({
    required this.name,
    required this.designation,
  });
}

class Plant {
  final String name;
  final List<Attendee> attendees;

  const Plant({
    required this.name,
    required this.attendees,
  });
}

class AttendeesScreen extends StatefulWidget {
  const AttendeesScreen({super.key});

  @override
  State<AttendeesScreen> createState() => _AttendeesScreenState();
}

class _AttendeesScreenState extends State<AttendeesScreen> {
  String selectedState = 'ANDHRA PRADESH';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  final List<String> states = const [
    'ANDHRA PRADESH',
    'TELANGANA',
    'KARNATAKA',
    'TAMILNADU',
  ];

  final Map<String, List<Plant>> stateData = const {
    'ANDHRA PRADESH': [
      Plant(
        name: 'Sri Damodaram Sanjeevaiah Thermal Power Station-AP Genco-Nellore',
        attendees: [
          Attendee(name: 'Mr. D.Rajendran', designation: 'EE'),
          Attendee(name: 'Mr. B.Vidya sagar', designation: 'AEE(I)'),
          Attendee(name: 'Mr. Avanigadda Naga Raju', designation: 'Deputy Executive Engineer'),
          Attendee(name: 'Mr. Mudasani Gopi Krishna', designation: 'Deputy Executive Engineer'),
          Attendee(name: 'Mr. Venkata SatyaNarayana', designation: 'Deputy Executive Engineer/I&C'),
        ],
      ),
      Plant(
        name: 'Dr.MVR Rayalaseema Thermal Power Project , AP-Genco-Kadapa',
        attendees: [
          Attendee(name: 'Mr. A.G. Subramanyam', designation: 'AEE'),
          Attendee(name: 'Mr. G.Chandra sekhar', designation: 'AEE'),
        ],
      ),
      Plant(
        name: 'Dr Narla Tata Rao Thermal power station-AP-Genco-Vijayawada',
        attendees: [
          Attendee(name: 'Mr. C.Narasimha Reddy', designation: 'Deputy Executive Engineer'),
          Attendee(name: 'Mr. B.Mutyalanaidu', designation: 'Deputy Executive Engineer'),
        ],
      ),
      Plant(
        name: 'Vedanta Power Limited-Nellore',
        attendees: [
          Attendee(name: 'Mr. Sourabh Mukharjee', designation: 'AGM'),
          Attendee(name: 'Mr. M.Selvaraj', designation: 'Deputy Manager'),
        ],
      ),
      Plant(
        name: 'Jindal power Ltd-Nellore',
        attendees: [
          Attendee(name: 'Mr. Muthukumar R', designation: 'Manager'),
          Attendee(name: 'Mr. Ashtosh kumar rai', designation: 'Deputy Manager'),
        ],
      ),
      Plant(
        name: 'Hinduja National Power Corporation Limited',
        attendees: [
          Attendee(name: 'Mr. P. Gopala Krishna', designation: 'Sr Manager'),
          Attendee(name: 'Mr. Nag Chandan Kumar', designation: 'Deputy Manager'),
        ],
      ),
    ],
    'TELANGANA': [
      Plant(
        name: 'Kothagudem Thermal power station-Stage-1',
        attendees: [
          Attendee(name: 'Mr. Gopi krishna', designation: 'DE-KTPS'),
          Attendee(name: 'Mr. Pradeep', designation: 'AE'),
        ],
      ),
      Plant(
        name: 'Kothagudem Thermal power station-Stage-2',
        attendees: [
          Attendee(name: 'Mr. Nalla srinivassarao', designation: 'DE'),
          Attendee(name: 'Mr. Sathish', designation: 'AEE'),
        ],
      ),
      Plant(
        name: 'Kakatiya Thermal power station',
        attendees: [
          Attendee(name: 'Mr. Y.Ravi', designation: 'DE'),
          Attendee(name: 'Mr. K.Veeresh', designation: 'AEE'),
        ],
      ),
      Plant(
        name: 'Bhadradri Thermal power station',
        attendees: [
          Attendee(name: 'Mr. Shankar', designation: 'ADE'),
          Attendee(name: 'Mr. Venkateswarulu', designation: 'ADE'),
        ],
      ),
    ],
    'KARNATAKA': [
      Plant(
        name: 'JSW Energy limited-Karnataka',
        attendees: [
          Attendee(name: 'Mr. Biswajit sahoo', designation: 'Senior Manager'),
          Attendee(name: 'Mr. Sasi kumar', designation: 'Asst manager'),
        ],
      ),
      Plant(
        name: 'Bellary Thermal Power Station/KPCLKudatini',
        attendees: [
          Attendee(name: 'Mr. Sreenivas .V.S', designation: 'S.E(I)'),
          Attendee(name: 'Ms. Neelima.G', designation: 'AEE(I)'),
          Attendee(name: 'Mr. V Nazneen Sultana', designation: 'AEE(I)'),
        ],
      ),
      Plant(
        name: 'Raichur Thermal Power Station',
        attendees: [
          Attendee(name: 'Mr. Sunil kumar H K', designation: 'Executive Engineer (I)'),
        ],
      ),
      Plant(
        name: 'NTPC LTD, Kudgi',
        attendees: [
          Attendee(name: 'Mr. P Sunil kumar', designation: 'DGM'),
        ],
      ),
    ],
    'TAMILNADU': [
      Plant(
        name: 'SEPC Power Pvt LTD -Tamilnadu',
        attendees: [
          Attendee(name: 'Mr. Vijeesh T Varghese', designation: 'Deputy Manager'),
          Attendee(name: 'Mr. P.prabhakaran', designation: 'Asst Manager'),
        ],
      ),
      Plant(
        name: 'NLC india limited-Neyveli',
        attendees: [
          Attendee(name: 'Mr. Arun Kailash', designation: 'Additional Chief Manager'),
        ],
      ),
      Plant(
        name: 'NLC Tamilnadu Power limited (NTPL)',
        attendees: [
          Attendee(name: 'Mr. V.A.Karthick', designation: 'ACM'),
          Attendee(name: 'Mr. Jagan Purushottam', designation: 'ACM'),
        ],
      ),
      Plant(
        name: 'TNEB -TNPGCL-NCTPP-stage-1,2,3',
        attendees: [
          Attendee(name: 'Mr. K.Sakthivel', designation: 'AE'),
          Attendee(name: 'Mr. S.Dinesh babu', designation: 'AE'),
          Attendee(name: 'Mr. M Sethuraman', designation: 'Chief Engineer-NCTPP-III'),
          Attendee(name: 'Mr. Logeshkumar R', designation: 'AE'),
          Attendee(name: 'Mr. A Arunraj', designation: 'Assistant Engineer'),
          Attendee(name: 'Mr. T Jeyaprabha', designation: 'Assistant Executive Engineer'),
          Attendee(name: 'Mr. Bhuvaneswaran', designation: 'Assistant Engineer'),
          Attendee(name: 'Mr. V Sankaran', designation: 'Assistant Executive Engineer'),
        ],
      ),
      Plant(
        name: 'IL&FS Tamil Nadu Power Company Ltd-Cuddalore',
        attendees: [
          Attendee(name: 'Mr. L Stephen Miller', designation: 'DGM'),
          Attendee(name: 'Mr. J Arun Kumar', designation: 'Senior Manager'),
        ],
      ),
      Plant(
        name: 'Moxie Power Generation Limited-Tuticorin',
        attendees: [
          Attendee(name: 'Mr. Yogaraj D', designation: 'Manager'),
        ],
      ),
    ],
  };

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Plant> _getFilteredPlants() {
    final List<Plant> plants = stateData[selectedState] ?? [];
    if (searchQuery.trim().isEmpty) return plants;

    final query = searchQuery.toLowerCase();
    final List<Plant> filtered = [];

    for (var plant in plants) {
      final plantMatches = plant.name.toLowerCase().contains(query);

      final matchingAttendees = plant.attendees.where((a) {
        return a.name.toLowerCase().contains(query) ||
            a.designation.toLowerCase().contains(query);
      }).toList();

      if (plantMatches || matchingAttendees.isNotEmpty) {
        filtered.add(
          Plant(
            name: plant.name,
            attendees: matchingAttendees.isNotEmpty ? matchingAttendees : plant.attendees,
          ),
        );
      }
    }

    return filtered;
  }

  String _getInitials(String name) {
    String cleanName = name
        .replaceAll(RegExp(r'^(Mr\.|Ms\.|Dr\.|Mrs\.)\s*', caseSensitive: false), '')
        .trim();
    
    List<String> parts = cleanName.split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlants = _getFilteredPlants();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          'ATTENDEES',
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
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search attendee or power plant...',
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
                      borderSide: const BorderSide(color: Color(0xFFF28C00), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: states.length,
                    itemBuilder: (context, index) {
                      final stateName = states[index];
                      final isSelected = selectedState == stateName;
                      
                      String displayName = stateName;
                      if (stateName == 'ANDHRA PRADESH') displayName = 'Andhra Pradesh';
                      if (stateName == 'TELANGANA') displayName = 'Telangana';
                      if (stateName == 'KARNATAKA') displayName = 'Karnataka';
                      if (stateName == 'TAMILNADU') displayName = 'Tamil Nadu';

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedState = stateName;
                            });
                          },
                          borderRadius: BorderRadius.circular(24),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF28C00)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFF28C00).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              displayName,
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF475569),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                fontSize: 13,
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
          ),
          Expanded(
            child: filteredPlants.isEmpty
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
                            'No Attendees Found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We couldn\'t find any attendees or power plants matching "$searchQuery".',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: filteredPlants.length,
                    itemBuilder: (context, index) {
                      final plant = filteredPlants[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFF1F5F9),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF28C00).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.factory_outlined,
                                      color: Color(0xFFF28C00),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      plant.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: plant.attendees.length,
                              separatorBuilder: (context, index) => const Divider(
                                color: Color(0xFFF8FAFC),
                                height: 1,
                                indent: 68,
                              ),
                              itemBuilder: (context, idx) {
                                final attendee = plant.attendees[idx];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color(0xFF246BFD).withOpacity(0.08),
                                        child: Text(
                                          _getInitials(attendee.name),
                                          style: const TextStyle(
                                            color: Color(0xFF246BFD),
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              attendee.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              attendee.designation,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF64748B),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
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
