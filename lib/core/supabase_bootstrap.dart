import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBootstrap {
  static const String projectId = 'iyvygogjnfhurebfires';
  static const String supabaseUrl = 'https://iyvygogjnfhurebfires.supabase.co';
  static const String redirectScheme = 'com.seilconnect';
  static const String redirectHost = 'callback';
  static const String redirectUrl = '$redirectScheme://$redirectHost';
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5dnlnb2dqbmZodXJlYmZpcmVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY3NzcwMDEsImV4cCI6MjA5MjM1MzAwMX0.Y0DzQmFTE2tDciL5gM4bq8p0r2vN9RDAV9-QTCop7yU',
  );

  static bool get isConfigured => anonKey.isNotEmpty;

  static Future<void> initialize() async {
    if (!isConfigured) return;
    await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  }
}
