import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/conference_repository.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController orgController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final Map<int, String> ratings = {};

  final TextEditingController likedMostController = TextEditingController();
  final TextEditingController improvementsController = TextEditingController();
  final TextEditingController additionalController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await ConferenceRepository().fetchCurrentProfile();
    if (mounted) {
      if (profile.fullName != 'Conference User' && profile.fullName.isNotEmpty) {
        nameController.text = profile.fullName;
      }
      if (profile.organization != 'Not Specified' && profile.organization.isNotEmpty) {
        orgController.text = profile.organization;
      }
      emailController.text = profile.email;
    }
  }

  final List<String> programQuestions = [
    'Overall conference experience?',
    'Event coordination and Management?',
    'Venue and hospitality?',
    'Audio and visual arrangements?',
    'Networking and opportunities?',
    'Food and Refreshments?',
  ];

  final List<String> ratingOptions = [
    'Excellent',
    'Very Good',
    'Good',
    'Average',
    'Poor'
  ];

  @override
  void dispose() {
    nameController.dispose();
    orgController.dispose();
    designationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    likedMostController.dispose();
    improvementsController.dispose();
    additionalController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    if (ratings.length < programQuestions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all rating questions in Section I.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;

      final data = {
        if (user != null) 'user_id': user.id,
        'participant_name': nameController.text.trim(),
        'organization': orgController.text.trim(),
        'designation': designationController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'event_date': dateController.text.trim(),
        'q1_experience': ratings[0],
        'q2_coordination': ratings[1],
        'q3_venue': ratings[2],
        'q4_audio_visual': ratings[3],
        'q5_networking': ratings[4],
        'q6_food': ratings[5],
        'liked_most': likedMostController.text.trim(),
        'improvements': improvementsController.text.trim(),
        'additional_comments': additionalController.text.trim(),
      };

      await client.from('feedback').insert(data);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully! Thank you.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submission Error: $e\n\nPlease ensure your database schema is updated to match the new form fields.'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 6),
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF3B82F6),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 60,
            color: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: const Color(0xFF1E293B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingQuestion(int index, String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. $question',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ratingOptions.map((option) {
              final isSelected = ratings[index] == option;
              return InkWell(
                onTap: () {
                  setState(() {
                    ratings[index] = option;
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isSelected ? Colors.white : Colors.white54,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentField(int index, String question, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. $question',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Type your answer here...',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'Feedback Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F172A),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Details
              _buildInputField('Participant Name', nameController),
              _buildInputField('Organization / Company', orgController),
              _buildInputField('Designation', designationController),
              _buildInputField('Email Address', emailController, type: TextInputType.emailAddress),
              _buildInputField('Phone Number', phoneController, type: TextInputType.phone),
              _buildInputField('Date of Event', dateController),

              // Section I
              _buildSectionHeader('I. PROGRAM COVERAGE'),
              ...List.generate(
                programQuestions.length,
                (index) => _buildRatingQuestion(index, programQuestions[index]),
              ),

              // Section II
              _buildSectionHeader('II. ADDITIONAL COMMENTS'),
              _buildCommentField(1, 'What did you like most about the conference?', likedMostController),
              _buildCommentField(2, 'What improvements would you suggest for future events?', improvementsController),
              _buildCommentField(3, 'Any additional feedback or comments?', additionalController),

              const SizedBox(height: 16),
              const Text(
                'Thank you for your valuable feedback and participation. We look forward to welcoming you to other future events.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: isLoading ? null : _submitFeedback,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Submit Feedback',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
