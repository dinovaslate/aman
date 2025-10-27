import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/form_button.dart';
import '../widgets/social_button_row.dart';
import '../widgets/text_field_group.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Creating account...'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldGroup(
              label: 'Full name',
              controller: _fullNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tell us your name';
                }
                return null;
              },
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms).moveY(begin: 12, curve: Curves.easeOut),
            const SizedBox(height: 18),
            TextFieldGroup(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(r'.+@.+[.].+');
                if (!emailRegex.hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms).moveY(begin: 12, curve: Curves.easeOut),
            const SizedBox(height: 18),
            TextFieldGroup(
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Minimum 8 characters';
                }
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Use at least one uppercase letter';
                }
                if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Use at least one number';
                }
                return null;
              },
            ).animate().fadeIn(duration: 300.ms, delay: 300.ms).moveY(begin: 12, curve: Curves.easeOut),
            const SizedBox(height: 18),
            TextFieldGroup(
              label: 'Confirm password',
              controller: _confirmPasswordController,
              isPassword: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ).animate().fadeIn(duration: 300.ms, delay: 400.ms).moveY(begin: 12, curve: Curves.easeOut),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox.adaptive(
                  value: _agreedToTerms,
                  onChanged: (value) => setState(() => _agreedToTerms = value ?? false),
                ),
                Expanded(
                  child: Text(
                    'I agree to the Terms & Privacy Policy',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 300.ms, delay: 500.ms).moveY(begin: 10),
            const SizedBox(height: 20),
            FormButton(
              label: 'Create Account',
              onPressed: _submit,
              icon: Icons.arrow_forward_rounded,
            ).animate().fadeIn(duration: 300.ms, delay: 600.ms).moveY(begin: 10),
            const SizedBox(height: 24),
            const SocialButtonRow(),
          ],
        ),
      ),
    );
  }
}
