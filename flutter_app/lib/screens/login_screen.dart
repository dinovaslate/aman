import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/form_button.dart';
import '../widgets/social_button_row.dart';
import '../widgets/text_field_group.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Logging in...'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          ).animate().fadeIn(duration: 300.ms, delay: 100.ms).moveY(begin: 12, curve: Curves.easeOut),
          const SizedBox(height: 20),
          TextFieldGroup(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Minimum 8 characters';
              }
              return null;
            },
          ).animate().fadeIn(duration: 300.ms, delay: 200.ms).moveY(begin: 12, curve: Curves.easeOut),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch.adaptive(
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value),
                  ),
                  const SizedBox(width: 8),
                  const Text('Remember me'),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms).moveY(begin: 10),
          const SizedBox(height: 24),
          FormButton(
            label: 'Login',
            onPressed: _submit,
            icon: Icons.login_rounded,
          ).animate().fadeIn(duration: 300.ms, delay: 400.ms).moveY(begin: 10),
          const SizedBox(height: 24),
          const SocialButtonRow(),
        ],
      ),
    );
  }
}
