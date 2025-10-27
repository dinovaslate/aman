import 'package:flutter/material.dart';

class TextFieldGroup extends StatefulWidget {
  const TextFieldGroup({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  State<TextFieldGroup> createState() => _TextFieldGroupState();
}

class _TextFieldGroupState extends State<TextFieldGroup> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscure : false,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(_obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
