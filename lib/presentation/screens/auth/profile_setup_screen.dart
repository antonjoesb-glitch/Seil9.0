import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repositories/conference_repository.dart';
import '../home/home_page.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key, required this.profile});
  final UserProfile profile;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  late final TextEditingController nameController;
  late final TextEditingController orgController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.profile.fullName == 'Conference User'
            ? ''
            : widget.profile.fullName);
    orgController = TextEditingController(
        text: widget.profile.organization == 'Not Specified'
            ? ''
            : widget.profile.organization);
  }

  Future<void> _saveProfile() async {
    if (nameController.text.trim().isEmpty) return;
    setState(() => isLoading = true);
    try {
      await ConferenceRepository().updateProfile(
        widget.profile.id,
        fullName: nameController.text.trim(),
        organization: orgController.text.trim(),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              ConferenceHomePage(userLabel: nameController.text.trim()),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save profile: $error')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: RepaintBoundary(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFF246BFD),
                            child: Icon(Icons.person_add_rounded,
                                color: Colors.white, size: 35),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Complete Your Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tell us who you are to personalize your experience.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _setupInputDecoration(
                                'Your Full Name', Icons.person_outline),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: orgController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _setupInputDecoration(
                                'Organization / Company',
                                Icons.business_outlined),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton(
                              onPressed: isLoading ? null : _saveProfile,
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF246BFD),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text('Continue to App',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _setupInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
      prefixIcon: Icon(icon, color: Colors.white.withValues(alpha: 0.5)),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF246BFD))),
    );
  }
}
