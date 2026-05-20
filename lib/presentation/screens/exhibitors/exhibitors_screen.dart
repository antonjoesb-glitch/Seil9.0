import 'package:flutter/material.dart';

class Exhibitor {
  final String companyName;
  final String representatives;
  final String stallNumber;

  const Exhibitor({
    required this.companyName,
    required this.representatives,
    required this.stallNumber,
  });
}

class ExhibitorsScreen extends StatelessWidget {
  const ExhibitorsScreen({super.key});

  final List<Exhibitor> exhibitors = const [
    Exhibitor(
      companyName: 'Schneider Electric',
      representatives: 'Mr. M. Maria Joseph, Mr. Abhay Thodge, Mr. Pulak Upadhyay',
      stallNumber: '01 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'Rockwell Automation',
      representatives: 'Mr. BALRAJ, Mr. Hari krishnan',
      stallNumber: '02 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'SIEMENS ENERGY INDIA LIMITED',
      representatives: 'Mr. ASHISH KULKARNI, Mr. UMANG SWARUP',
      stallNumber: '03 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'HACH',
      representatives: 'Mr. Siddaram S Sholapur, Mr. Suresh Bokka',
      stallNumber: '4 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'Forbes Marshall Pvt Ltd',
      representatives: 'Mr. Nitin Joshi, Mr. ADITYA',
      stallNumber: '05 & 06 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'Moog Motion Controls Pvt. Ltd.',
      representatives: 'Mr. Arularasan Thiagarajan, Mr. Mahesh Barve, Mr. Jayesh Nambiar',
      stallNumber: '07 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'EIP Enviro Level Controls Pvt Ltd',
      representatives: 'Dr Abhishek Goyal',
      stallNumber: '08 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'Sheetal wireless technologies private limited',
      representatives: 'Mr. Rajkumar R, Mr. Mahesh Awashank',
      stallNumber: '09 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'MICRO BUSINESS SOLUTIONS',
      representatives: 'Mr. S.N.MAHENDIRAN, Mr. SHUBHAM GUPTA',
      stallNumber: '10 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'Jaaji Technologies',
      representatives: 'Mr. Venkatesh Kondeti, Mr. Thrinath Velaga, Mr. M Jagan',
      stallNumber: '11 (Ground floor, Hall-2)',
    ),
    Exhibitor(
      companyName: 'EMERSON PROCESS MANAGEMENT CHENNAI PVT LTD',
      representatives: 'Mr Krishnamoothy , Mr Selvam',
      stallNumber: '12 (Ground floor .Hall-2)',
    ),
    Exhibitor(
      companyName: 'NK SQARE SOLUTIONS PVT LTD',
      representatives: 'Mr Muralikrishna , Mr Surendra',
      stallNumber: '13 (Ground floor .Hall-2)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          'EXHIBITORS',
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: exhibitors.length,
        itemBuilder: (context, index) {
          final exhibitor = exhibitors[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF13A67E).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.storefront_rounded,
                                  color: Color(0xFF13A67E),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exhibitor.companyName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.badge_outlined,
                                          size: 18,
                                          color: Color(0xFF64748B),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            exhibitor.representatives,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF475569),
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: Color(0xFF334155),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Stall ${exhibitor.stallNumber}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF334155),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
