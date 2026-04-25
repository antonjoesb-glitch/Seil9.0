import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSEILScreen extends StatelessWidget {
  const AboutSEILScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ABOUT SEIL',
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
          // LayoutBuilder for responsive
          LayoutBuilder(
            builder: (context, constraints) {
              final leftBlock = _buildLeftBlock();
              final rightBlocks = _buildRightBlocks();

              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: leftBlock),
                    const SizedBox(width: 32),
                    Expanded(flex: 1, child: rightBlocks),
                  ],
                );
              }
              return Column(
                children: [
                  leftBlock,
                  const SizedBox(height: 24),
                  rightBlocks,
                ],
              );
            },
          ),
          const SizedBox(height: 48),

          // Link Text
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Link of our website: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () async {
                  final url = Uri.parse('https://www.seilenergy.com/about-us');
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    debugPrint('Could not launch $url');
                  }
                },
                child: const Text('https://www.seilenergy.com/about-us',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A90E2),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF4A90E2))),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildLeftBlock() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Color(0xFF4C6A2E), // Dark Olive Green
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Energising Nations with Integrity,\nImpact, & Precision',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "As one of India's leading independent power producers, operating a world-class 2,640 MW supercritical thermal power complex with four advanced 660 MW units in SPSR Nellore, Andhra Pradesh, we play a critical role in fortifying India's energy security and meeting the nation's rapidly rising energy needs. Every watt we generate carries a promise of continuity for industries, stability for communities, and confidence in the nation's future.",
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.6),
          ),
          SizedBox(height: 16),
          Text(
            "Guided by sustainability and driven by engineering excellence, SEIL Energy works with intent and integrity across every step of the energy chain. Through our reliable power generation, we are committed to offering a viable and best-in-class energy supply to meet the country's need for dependable and sustainable power.",
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildRightBlocks() {
    return Column(
      children: [
        _buildRightCard(
          color: const Color(0xFF6B8444),
          title: 'Purpose in Every Watt We\nCreate',
          content:
              "SEIL Energy's purpose and commitment are centred on shaping a more sustainable future with intent. Our vision is to be a leading provider of reliable and sustainable energy solutions, strengthening India and the subcontinent in their growth, while generating lasting value for our stakeholders and communities.",
          iconData: Icons.trending_up, // Using a standard icon to mock abstract arrow
        ),
        const SizedBox(height: 24),
        _buildRightCard(
          color: const Color(0xFF1B2236),
          title: 'Values that Power Our Culture',
          content:
              "At the heart of SEIL Energy are three guiding values: Institution First, Collaboration, and Accountability. These principles are embedded into daily actions and behaviours through our policies and frameworks, shaping a unified organisational culture grounded in integrity, purpose, and shared responsibility.",
          iconData: Icons.auto_awesome, // Using a standard icon to mock abstract star
        ),
      ],
    );
  }

  Widget _buildRightCard(
      {required Color color,
      required String title,
      required String content,
      required IconData iconData}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(iconData,
                color: Colors.white.withValues(alpha: 0.3), size: 56),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.2)),
          const SizedBox(height: 16),
          Text(content,
              style:
                  const TextStyle(color: Colors.white, fontSize: 12, height: 1.6)),
        ],
      ),
    );
  }
}
