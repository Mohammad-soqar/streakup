import 'package:flutter/material.dart';

Widget DividerSectionTitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 4),
      Divider(thickness: 1.2),
      const SizedBox(height: 12),
    ],
  );
}
