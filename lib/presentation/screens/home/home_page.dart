import 'package:flutter/material.dart';
import '../../../core/guest_session.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/agenda_item.dart';
import '../../../data/models/feature_item.dart';
import '../../../data/repositories/conference_repository.dart';
import '../../widgets/feature_tile.dart';
import '../../widgets/agenda_card.dart';
import '../../widgets/simple_state_card.dart';
import '../../widgets/profile_detail_row.dart';
import '../about/about_event_screen.dart';
import '../about/about_seil_screen.dart';
import '../venue/venue_screen.dart';
import '../help/help_screen.dart';
import '../feedback/feedback_screen.dart';
import '../paper_presentation/paper_presentation_screen.dart';
import '../calendar/event_calendar_screen.dart';
import '../auth/auth_gate.dart';
import '../exhibitors/exhibitors_screen.dart';
import '../floor_plan/floor_plan_screen.dart';
import '../attendees/attendees_screen.dart';
import '../speakers/speakers_screen.dart';

class ConferenceHomePage extends StatefulWidget {
  const ConferenceHomePage({super.key, this.userLabel});

  final String? userLabel;

  @override
  State<ConferenceHomePage> createState() => _ConferenceHomePageState();
}

class _ConferenceHomePageState extends State<ConferenceHomePage> {
  int selectedTabIndex = 0;
  final ConferenceRepository repository = ConferenceRepository();

  final List<FeatureItem> coreFeatures = const [
    FeatureItem('About Event', Icons.rocket_launch_rounded, Color(0xFFF28C00)),
    FeatureItem('About SEIL', Icons.info_outline_rounded, Color(0xFF8E5CFF)),
    FeatureItem('My Profile', Icons.person_outline_rounded, Color(0xFFE1007A)),
    FeatureItem('Help', Icons.help_outline_rounded, Color(0xFF12A66A)),
    FeatureItem('Event Calendar', Icons.calendar_month_rounded, Color(0xFF4A90FF)),
    FeatureItem('Speakers', Icons.groups_2_rounded, Color(0xFF9A62FF)),
    FeatureItem('Exhibitors', Icons.storefront_rounded, Color(0xFF13A67E)),
    FeatureItem('Attendees', Icons.diversity_3_rounded, Color(0xFFF28C00)),
    FeatureItem(
      'Paper Presentation',
      Icons.slideshow_rounded,
      Color(0xFFDBB700),
    ),
    FeatureItem('Feedback', Icons.feedback_outlined, Color(0xFF9A62FF)),
    FeatureItem('Venue', Icons.location_city_rounded, Color(0xFF18A570)),
    FeatureItem('Floor Plan', Icons.layers_rounded, Color(0xFF4A90FF)),
  ];

  late Future<UserProfile> profileFuture;
  late Future<List<AgendaItem>> agendaFuture;

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  void _reloadData() {
    profileFuture = repository.fetchCurrentProfile(fallbackLabel: widget.userLabel);
    agendaFuture = repository.fetchAgendaItems();
  }

  Future<void> _refreshData() async {
    setState(_reloadData);
    await Future.wait([profileFuture, agendaFuture]);
  }

  Future<void> _signOut() async {
    await repository.signOut();
    LocalGuestSession.disable();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthGate()),
      (route) => false,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Signed out successfully.')));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedTabIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (selectedTabIndex != 0) {
          setState(() => selectedTabIndex = 0);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8FF),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedTabIndex,
          onDestinationSelected: (index) => setState(() => selectedTabIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.help_outline), label: 'Help'),
            NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
        body: RepaintBoundary(
          child: IndexedStack(
            index: selectedTabIndex,
            children: [
              _buildHomeTab(),
              const HelpScreen(),
              _buildProfileTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar.large(
          pinned: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            "SEIL's CONCLAVE - C&I CONNECT 2026",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh_rounded)),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: _buildHeroCard(widget.userLabel),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Core Conference Modules',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.83,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final feature = coreFeatures[index];
              return FeatureTile(
                item: feature,
                onTap: () {
                  if (feature.title == 'About Event') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AboutEventScreen()),
                    );
                  } else if (feature.title == 'About SEIL') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AboutSEILScreen()),
                    );
                  } else if (feature.title == 'Venue') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const VenueScreen()),
                    );
                  } else if (feature.title == 'Help') {
                    setState(() => selectedTabIndex = 1);
                  } else if (feature.title == 'Feedback') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                    );
                  } else if (feature.title == 'Paper Presentation') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PaperPresentationScreen()),
                    );
                  } else if (feature.title == 'Exhibitors') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ExhibitorsScreen()),
                    );
                  } else if (feature.title == 'Floor Plan') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FloorPlanScreen()),
                    );
                  } else if (feature.title == 'My Profile') {
                    setState(() => selectedTabIndex = 2);
                  } else if (feature.title == 'Event Calendar') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const EventCalendarScreen()),
                    );
                  } else if (feature.title == 'Attendees') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AttendeesScreen()),
                    );
                  } else if (feature.title == 'Speakers') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SpeakersScreen()),
                    );
                  }
                },
              );
            }, childCount: coreFeatures.length),
          ),
        ),
      ],
    );
  }

  Widget _buildAgendaTab() {
    return SafeArea(
      child: FutureBuilder<List<AgendaItem>>(
        future: agendaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return SimpleStateCard(
              title: 'Unable to load agenda',
              message: '${snapshot.error}',
              onRetry: _refreshData,
            );
          }
          final items = snapshot.data ?? const <AgendaItem>[];
          if (items.isEmpty) {
            return SimpleStateCard(
              title: 'No agenda found',
              message: 'Add rows in "agenda_items" table to show sessions.',
              onRetry: _refreshData,
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length + 1,
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1E293B)),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'My Agenda',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                  );
                }
                final item = items[index - 1];
                return AgendaCard(item: item);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileTab() {
    return SafeArea(
      child: FutureBuilder<UserProfile>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return SimpleStateCard(
              title: 'Unable to load profile',
              message: '${snapshot.error}',
              onRetry: _refreshData,
            );
          }
          final profile = snapshot.data ?? const UserProfile();
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => selectedTabIndex = 0),
                      icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1E293B)),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'My Profile',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Premium Profile Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFF246BFD).withValues(alpha: 0.1),
                        child: const Icon(Icons.person_rounded, size: 60, color: Color(0xFF246BFD)),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profile.fullName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                      ),
                      Text(
                        profile.role,
                        style: const TextStyle(fontSize: 16, color: Color(0xFF246BFD), fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 24),
                      const Divider(height: 1),
                      const SizedBox(height: 24),
                      ProfileDetailRow(icon: Icons.email_outlined, label: 'Email', value: profile.email),
                      const SizedBox(height: 16),
                      ProfileDetailRow(icon: Icons.business_outlined, label: 'Organization', value: profile.organization),
                      const SizedBox(height: 16),
                      ProfileDetailRow(icon: Icons.info_outline, label: 'Bio', value: profile.bio.isEmpty ? 'Conference Attendee' : profile.bio),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _refreshData,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Refresh'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _signOut,
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text('Logout'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(String? userLabel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sustainable Solutions Through Advanced Instrumentation and Cyber-Resilient Control Systems in Thermal Power Plants',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
