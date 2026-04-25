import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final Map<int, int> ratings = {};
  final TextEditingController suggestionsController = TextEditingController();
  bool isLoading = false;

  final List<String> questions = [
    'Content of the Conference',
    'On site Arrival and Process of Registration',
    'The Venue',
    'The Catering (Food and Drinks)',
    'Event Hotel/Accommodation',
    'Sessions/Proceeding',
  ];

  Future<void> _submitFeedback() async {
    setState(() => isLoading = true);
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;

      final data = {
        if (user != null) 'user_id': user.id,
        'q1_content': ratings[0],
        'q2_arrival': ratings[1],
        'q3_venue': ratings[2],
        'q4_catering': ratings[3],
        'q5_hotel': ratings[4],
        'q6_sessions': ratings[5],
        'suggestions': suggestionsController.text.trim(),
      };

      await client.from('feedback').insert(data);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Feedback submitted successfully! Thank you.')),
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
        title: const Text('Feedback Form',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w400)),
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
            const Text(
              'Please indicate your level of statifaction in a scale of 1-10 (1 Min & 10 Max)',
              style: TextStyle(
                  fontSize: 16, color: Color(0xFF333333), height: 1.4),
            ),
            const SizedBox(height: 32),
            ...List.generate(questions.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${index + 1}. ${questions[index]}',
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF333333)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 70,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 1),
                        ),
                        maxLength: 2,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            null,
                        onChanged: (val) {
                          final valInt = int.tryParse(val);
                          if (valInt != null && valInt >= 1 && valInt <= 10) {
                            ratings[index] = valInt;
                          } else {
                            ratings.remove(index);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Text('7. Suggestions for Improvements',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: suggestionsController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              height: 52,
              width: 140,
              child: FilledButton(
                onPressed: isLoading ? null : _submitFeedback,
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
