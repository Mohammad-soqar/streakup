import 'package:flutter/material.dart';

class CustomSelectField extends StatefulWidget {
  final String labelText;
  final String? value;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final Function(String?) onChanged;

  const CustomSelectField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  });

  @override
  _CustomSelectFieldState createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
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

          // Select Field
          DropdownButtonFormField<String>(
            value: widget.value,
            validator: widget.validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return "${widget.labelText} is required";
                  }
                  return null;
                },
            onChanged: widget.onChanged,
            items: widget.items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            decoration: InputDecoration(
              hintText: 'Select ${widget.labelText}',
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.onInverseSurface,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
