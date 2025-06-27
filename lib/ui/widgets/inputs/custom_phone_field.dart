// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String? initialCountryCode;
  final String? initialValue;
  final String labelText;
  final TextEditingController controller;

  const CustomPhoneField({
    super.key,
    this.onChanged,
    required this.controller,
    required this.labelText,
    this.initialCountryCode,
    this.initialValue,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String fullNumber = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 5),
          IntlPhoneField(
            initialCountryCode: widget.initialCountryCode ?? 'SA',
            initialValue: widget.initialValue,
            flagsButtonPadding: const EdgeInsets.only(left: 10),
            dropdownIconPosition: IconPosition.trailing,
            dropdownIcon: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            onChanged: (phone) {
              fullNumber = phone.completeNumber;

              // 👉 Only set the full number in your controller here
              widget.controller.text = fullNumber;

              if (widget.onChanged != null) {
                widget.onChanged!(fullNumber);
              }
            },
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            dropdownDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
