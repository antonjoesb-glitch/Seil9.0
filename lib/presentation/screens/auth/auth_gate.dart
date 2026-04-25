import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/conference_repository.dart';
import 'sign_in_screen.dart';
import 'reset_password_screen.dart';
import 'profile_setup_screen.dart';
import '../home/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ConferenceRepository();
    final authStream = Supabase.instance.client.auth.onAuthStateChange;
    return StreamBuilder<AuthState>(
      stream: authStream,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? Supabase.instance.client.auth.currentSession;
        final event = snapshot.data?.event;

        // Debug logging
        if (event != null) {
          debugPrint('AuthGate Event: $event');
          debugPrint('Session present: ${session != null}');
        }

        if (event == AuthChangeEvent.passwordRecovery) {
          return const ResetPasswordScreen();
        }

        if (session == null) {
          return const SignInScreen();
        }
        return FutureBuilder<UserProfile>(
          future: repository.fetchAndEnsureProfile(session.user),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (profileSnapshot.hasError) {
              debugPrint('Profile Error: ${profileSnapshot.error}');
              return Scaffold(
                body: Center(
                  child: Text('Error loading profile: ${profileSnapshot.error}'),
                ),
              );
            }

            final profile = profileSnapshot.data;
            if (profile == null) {
              debugPrint('Profile is null after fetch');
              return const SignInScreen();
            }

            if (profile.needsSetup) {
              return ProfileSetupScreen(profile: profile);
            }

            return ConferenceHomePage(userLabel: profile.fullName);
          },
        );
      },
    );
  }
}
