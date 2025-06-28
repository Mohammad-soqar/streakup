// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomDateField({
    super.key,
    required this.labelText,
    required this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _pickDate(BuildContext context) async {
    DateTime initialDate = widget.initialDate ?? DateTime.now();

    // Try to parse from the field if it exists
    if (widget.controller.text.isNotEmpty) {
      try {
        initialDate = _dateFormat.parse(widget.controller.text);
      } catch (_) {}
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      widget.controller.text = _dateFormat.format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Column
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          // TextFormField
          controller: widget.controller,
          keyboardType: TextInputType.number, // allow numbers only

          inputFormatters: [DateInputFormatter()], // 👈 apply custom formatter

          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          decoration: InputDecoration(
            hintText: "Select ${widget.labelText}",
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.onInverseSurface,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () => _pickDate(context),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "${widget.labelText} is required";
            }
            try {
              _dateFormat.parseStrict(value); // validates strict dd/MM/yyyy
            } catch (_) {
              return "Enter date as dd/MM/yyyy";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length && i < 8; i++) {
      buffer.write(digitsOnly[i]);
      if ((i == 1 || i == 3) && i != digitsOnly.length - 1) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
