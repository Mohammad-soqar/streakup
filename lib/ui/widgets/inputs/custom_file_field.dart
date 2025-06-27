// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomFileField extends StatelessWidget {
  final String labelText;
  final VoidCallback onTapped;

  const CustomFileField({
    super.key,
    required this.labelText,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = Theme.of(context).colorScheme.surfaceVariant;
    final textColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTapped,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload a file',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.upload, color: textColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
