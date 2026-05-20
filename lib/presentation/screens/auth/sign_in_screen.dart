import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase_bootstrap.dart';
import '../../widgets/social_auth_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isSignUp = false;
  bool isPasswordVisible = false;
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailAuth() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Ultra-Strict Regex: Only allows emails that end in .com
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+com$');
    final isEmailValid = emailRegex.hasMatch(email);

    setState(() {
      emailError = email.isEmpty 
          ? 'Email is required' 
          : (!isEmailValid ? 'Only .com email addresses are allowed' : null);
      passwordError = password.isEmpty ? 'Password is required' : null;
    });

    if (emailError != null || passwordError != null) return;

    if (isSignUp && password.length < 6) {
      setState(() => passwordError = 'Must be at least 6 characters');
      return;
    }

    setState(() => isLoading = true);

    try {
      if (isSignUp) {
        final response = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );

        if (response.session != null) {
          _showNotification('Welcome! Account created successfully.');
        } else {
          _showNotification('Check your email inbox to verify your account.',
              isError: false);
        }
      } else {
        await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );
      }
    } catch (error) {
      final errorMsg = error.toString().toLowerCase();
      if (errorMsg.contains('invalid login credentials')) {
        setState(() => passwordError = 'Incorrect email or password');
      } else if (errorMsg.contains('email_not_confirmed')) {
        _showNotification('Please verify your email before logging in.');
      } else {
        _showNotification(error.toString().split(":").last.trim());
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showNotification(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            isError ? const Color(0xFFE1007A) : const Color(0xFF246BFD),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _handleForgotPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      setState(() => emailError = 'Enter your email to reset password');
      return;
    }

    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: SupabaseBootstrap.redirectUrl,
      );
      _showNotification('Password reset link sent to your email.',
          isError: false);
    } catch (error) {
      _showNotification(
          'Reset failed: ${error.toString().split(":").last.trim()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _continueWithGoogle() async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : SupabaseBootstrap.redirectUrl,
      );
    } catch (error) {
      _showNotification('Google sign-in failed: $error');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
              ),
            ),
          ),
          // Background Blobs
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF246BFD).withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE1007A).withValues(alpha: 0.1),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: RepaintBoundary(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 430,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF246BFD)
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.event_available_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Text(
                                    'Conference Hub',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              isSignUp
                                  ? 'Create your account to join the conference.'
                                  : 'Sign in to access your dashboard and event schedule.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6)),
                                hintText: 'yourname@example.com',
                                hintStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.3)),
                                errorText: emailError,
                                errorStyle:
                                    const TextStyle(color: Color(0xFFFF4D4D)),
                                prefixIcon: Icon(Icons.alternate_email_rounded,
                                    color: Colors.white.withValues(alpha: 0.5)),
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.05),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white
                                      .withValues(alpha: 0.1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF246BFD), width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFF4D4D), width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFF4D4D), width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6)),
                                hintText: '••••••••',
                                hintStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.3)),
                                errorText: passwordError,
                                errorStyle:
                                    const TextStyle(color: Color(0xFFFF4D4D)),
                                prefixIcon: Icon(Icons.lock_outline_rounded,
                                    color: Colors.white.withValues(alpha: 0.5)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white.withValues(alpha: 0.5),
                                    size: 20,
                                  ),
                                  onPressed: () => setState(() =>
                                      isPasswordVisible = !isPasswordVisible),
                                ),
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.05),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white
                                      .withValues(alpha: 0.1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF246BFD), width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFF4D4D), width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFF4D4D), width: 2),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed:
                                    isLoading ? null : _handleForgotPassword,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: FilledButton(
                                onPressed: isLoading ? null : _handleEmailAuth,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF246BFD),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white))
                                    : Text(
                                        isSignUp ? 'Create Account' : 'Sign In',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: TextButton(
                                onPressed: () => setState(() {
                                  isSignUp = !isSignUp;
                                  emailError = null;
                                  passwordError = null;
                                }),
                                child: RichText(
                                  text: TextSpan(
                                    text: isSignUp
                                        ? 'Already have an account? '
                                        : 'New to Conference Hub? ',
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.6),
                                        fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: isSignUp
                                            ? 'Sign In'
                                            : 'Create Account',
                                        style: const TextStyle(
                                          color: Color(0xFF246BFD),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                        color: Colors.white
                                            .withValues(alpha: 0.1))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                        color: Colors.white
                                            .withValues(alpha: 0.1))),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SocialAuthButton(
                              onPressed:
                                  isLoading ? null : _continueWithGoogle,
                              icon: Icons.account_circle_outlined,
                              label: 'Continue with Google',
                            ),
                          ],
                        ),
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
}
