/* // ignore_for_file: deprecated_member_use

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:medflo/utils/nationality_mapper.dart';

class CustomNationalityPicker extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final void Function(Country)? onSelect;
  final String? nationalityCode; // <-- this is the MRZ code (e.g., "SYR")

  const CustomNationalityPicker({
    super.key,
    required this.labelText,
    required this.controller,
    this.onSelect,
    this.nationalityCode,
  });

  @override
  State<CustomNationalityPicker> createState() =>
      _CustomNationalityPickerState();
}

class _CustomNationalityPickerState extends State<CustomNationalityPicker> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _setCountryFromCode(widget.nationalityCode);
  }

  void _setCountryFromCode(String? code) {
    if (code == null || code.isEmpty) return;

    final name = alpha3ToNationalityName[code.toUpperCase()];
    if (name != null) {
      widget.controller.text = name;
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
        GestureDetector(
          onTap: () {
            showCountryPicker(
              exclude: <String>['IL'],
              context: context,
              showPhoneCode: false,
              countryListTheme: CountryListThemeData(
                flagSize: 25,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                bottomSheetHeight: 500,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              onSelect: (Country country) {
                setState(() {
                  _selectedCountry = country;
                  widget.controller.text = country.name;
                });
                if (widget.onSelect != null) {
                  widget.onSelect!(country);
                }
              },
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                if (_selectedCountry != null) ...[
                  Text(_selectedCountry!.flagEmoji,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedCountry!.name,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ] else
                  Text(
                    'Select ${widget.labelText}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
 */