// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final String details;
  final void Function(bool?) onChanged;
  final bool value;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.details,
    required this.onChanged,
    required this.value,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: () => widget.onChanged(!widget.value),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: widget.value
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    width: 2,
                  ),
                ),
                child: widget.value
                    ? Icon(
                        Icons.check,
                        size: 18,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                widget.details,
                style: TextStyle(
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
