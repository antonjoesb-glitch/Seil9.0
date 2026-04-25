import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  Future<void> _resetPassword() async {
    final password = passwordController.text.trim();
    if (password.length < 6) {
      setState(() => errorText = 'Password must be at least 6 characters');
      return;
    }

    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: password),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Password updated successfully! Log in with your new password.')),
      );
    } catch (error) {
      setState(() => errorText =
          'Failed to update: ${error.toString().split(":").last.trim()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_reset_rounded,
                    color: Colors.white, size: 64),
                const SizedBox(height: 24),
                const Text(
                  'Set New Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter a strong password to secure your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle:
                        TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                    errorText: errorText,
                    errorStyle: const TextStyle(color: Color(0xFFFF4D4D)),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: isLoading ? null : _resetPassword,
                    style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF246BFD)),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Update Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
