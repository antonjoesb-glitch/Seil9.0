import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../models/agenda_item.dart';

class ConferenceRepository {
  SupabaseClient? _tryClient() {
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  Future<UserProfile> fetchCurrentProfile({String? fallbackLabel}) async {
    final client = _tryClient();
    if (client == null) {
      return UserProfile(email: fallbackLabel ?? 'guest@conference.app');
    }

    final user = client.auth.currentUser;
    if (user == null) return const UserProfile();

    try {
      final raw = await client
          .from('profiles')
          .select('id,full_name,email,organization,role')
          .eq('id', user.id)
          .maybeSingle();
      if (raw == null) {
        return UserProfile(
          id: user.id,
          fullName: user.userMetadata?['full_name']?.toString() ?? 'Conference User',
          email: user.email ?? fallbackLabel ?? 'user@conference.app',
        );
      }
      return UserProfile.fromMap(raw);
    } catch (_) {
      return UserProfile(
        id: user.id,
        fullName: user.userMetadata?['full_name']?.toString() ?? 'Conference User',
        email: user.email ?? fallbackLabel ?? 'user@conference.app',
      );
    }
  }

  Future<UserProfile> fetchAndEnsureProfile(User user) async {
    final client = _tryClient();
    if (client == null) {
      return UserProfile(id: user.id, email: user.email ?? '');
    }

    try {
      final raw = await client.from('profiles').select().eq('id', user.id).maybeSingle();
      if (raw == null) {
        final email = user.email ?? '';
        final fullName = user.userMetadata?['full_name']?.toString() ?? 'Conference User';
        final newProfile = {
          'id': user.id,
          'full_name': fullName,
          'email': email,
          'organization': 'Not Specified',
          'role': 'Attendee',
        };
        await client.from('profiles').insert(newProfile);
        return UserProfile.fromMap(newProfile);
      }
      return UserProfile.fromMap(raw);
    } catch (_) {
      return UserProfile(id: user.id, email: user.email ?? '');
    }
  }

  Future<void> updateProfile(String id, {required String fullName, String? organization}) async {
    final client = _tryClient();
    if (client == null) return;
    await client.from('profiles').update({
      'full_name': fullName,
      if (organization != null) 'organization': organization,
    }).eq('id', id);
  }

  Future<List<AgendaItem>> fetchAgendaItems() async {
    final client = _tryClient();
    if (client == null) return _fallbackAgenda();
    try {
      final rows = await client
          .from('agenda_items')
          .select('title,speaker,room,start_at,description')
          .order('start_at') as List<dynamic>;
      if (rows.isEmpty) return _fallbackAgenda();
      return rows
          .whereType<Map<String, dynamic>>()
          .map(AgendaItem.fromMap)
          .toList(growable: false);
    } catch (_) {
      return _fallbackAgenda();
    }
  }

  List<AgendaItem> _fallbackAgenda() {
    final now = DateTime.now();
    return [
      AgendaItem(
        title: 'Inaugural Keynote',
        speaker: 'Chief Guest',
        room: 'Grand Auditorium',
        startAt: now,
        description: 'Opening session for IPS Conference.',
      ),
      AgendaItem(
        title: 'Thermal Efficiency Panel',
        speaker: 'Industry Leaders',
        room: 'Hall B',
        startAt: now.add(const Duration(hours: 2)),
        description: 'Discussion on reliability and optimization.',
      ),
    ];
  }

  Future<void> signOut() async {
    final client = _tryClient();
    if (client == null) return;
    if (client.auth.currentSession != null) {
      await client.auth.signOut();
    }
  }
}
