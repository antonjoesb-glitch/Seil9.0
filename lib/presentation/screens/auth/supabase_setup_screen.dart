import 'package:flutter/material.dart';

class SupabaseSetupScreen extends StatelessWidget {
  const SupabaseSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(title: const Text('Conference Hub Setup')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supabase configuration is pending.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text('Project ID: qhjyykfjpfsfzqmfzatp'),
              SizedBox(height: 6),
              SelectableText(
                'Run with:\nflutter run --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
