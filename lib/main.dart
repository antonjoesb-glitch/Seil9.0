import 'package:flutter/material.dart';
import 'core/supabase_bootstrap.dart';
import 'presentation/screens/auth/auth_gate.dart';
import 'presentation/screens/auth/supabase_setup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseBootstrap.initialize();
  runApp(const ConferenceApp());
}

class ConferenceApp extends StatelessWidget {
  const ConferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEIL CONNECT',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF246BFD),
          brightness: Brightness.light,
        ),
      ),
      home: SupabaseBootstrap.isConfigured
          ? const AuthGate()
          : const SupabaseSetupScreen(),
    );
  }
}
