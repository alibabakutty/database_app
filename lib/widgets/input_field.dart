import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onTab;
  final List<TextInputFormatter>? inputFormatters;
  final bool centerLabel;
  final bool showRupeeSymbol;
  final bool readOnly;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onTab,
    this.inputFormatters,
    this.centerLabel = false,
    this.showRupeeSymbol = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerLabel ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true, // Reduce height of the input field
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0, // Reduced vertical padding
            ),
            prefixIcon: showRupeeSymbol
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: showRupeeSymbol
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
          ),
          onTap: onTab,
          style: const TextStyle(fontSize: 14),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
