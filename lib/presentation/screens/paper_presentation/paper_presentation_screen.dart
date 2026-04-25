import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaperPresentationScreen extends StatefulWidget {
  const PaperPresentationScreen({super.key});

  @override
  State<PaperPresentationScreen> createState() =>
      _PaperPresentationScreenState();
}

class _PaperPresentationScreenState extends State<PaperPresentationScreen> {
  final List<String> areaOptions = [
    'Advanced DCS / PLC / SCADA & Digital Control Solutions',
    'Industrial IoT & Cybersecurity',
    'Predictive Maintenance & AI/ML',
    'Flexible Operations',
    'Implementation of AGC',
    'Environmental Compliance Strategy',
    'Best Maintenance Practices'
  ];

  String? selectedArea;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController abstractController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitPaper() async {
    if (selectedArea == null ||
        titleController.text.trim().isEmpty ||
        abstractController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the required fields.')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;

      final data = {
        if (user != null) 'user_id': user.id,
        'area': selectedArea,
        'title': titleController.text.trim(),
        'abstract_text': abstractController.text.trim(),
      };

      await client.from('paper_presentations').insert(data);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Paper Presentation submitted successfully!')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Abstract',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
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
            const Text('Area *',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedArea,
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child:
                        Text('Select', style: TextStyle(color: Colors.black87)),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ),
                  items: areaOptions.map((area) {
                    return DropdownMenuItem(
                      value: area,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(area, overflow: TextOverflow.ellipsis),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => selectedArea = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Title *',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: titleController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Abstract (up to 250 words) *',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: abstractController,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: FilledButton(
                onPressed: isLoading ? null : _submitPaper,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF22A366),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Submit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
