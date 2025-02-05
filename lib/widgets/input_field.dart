import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onTab;
  final List<TextInputFormatter>? inputFormatters;
  final bool centerLabel;
  final bool showRupeeSymbol;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final bool formatToTwoDecimals;
  final bool isDateField;

  const InputField({
    super.key,
    required this.label,
    this.hintText = '',
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onTab,
    this.inputFormatters,
    this.centerLabel = false,
    this.showRupeeSymbol = false,
    this.readOnly = false,
    this.onChanged,
    this.formatToTwoDecimals = false,
    this.isDateField = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final NumberFormat _formatter = NumberFormat("#,##0.00", "en-IN");
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Listener to detect when focus is lost(onBlur)
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _formatAmount();
      }
    });
    if (widget.isDateField && widget.controller.text.isEmpty) {
      _setCurrentDate();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _setCurrentDate() {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    widget.controller.text = formattedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (widget.controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd-MM-yyyy').parse(widget.controller.text);
      } catch (_) {}
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  // Function to format input to two decimal places and add commas
  void _formatAmount() {
    if (!widget.formatToTwoDecimals) return;

    String input = widget.controller.text.replaceAll(',', '').trim();
    if (input.isEmpty) return;

    double? amount = double.tryParse(input);
    if (amount != null) {
      setState(() {
        widget.controller.text = _formatter.format(amount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.centerLabel
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.formatToTwoDecimals
              ? _focusNode
              : null, // Attach FocusNode
          keyboardType: widget.isDateField
              ? TextInputType.none
              : (widget.formatToTwoDecimals
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : widget.keyboardType),
          inputFormatters: widget.formatToTwoDecimals
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))]
              : widget.inputFormatters,
          readOnly: widget.isDateField || widget.readOnly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true, // Reduce height of the input field
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0, // Reduced vertical padding
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            prefixIcon: widget.showRupeeSymbol
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
            prefixIconConstraints: widget.showRupeeSymbol
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            suffixIcon:
                widget.isDateField ? const Icon(Icons.calendar_today) : null,
          ),
          onTap: widget.isDateField ? () => _selectDate(context) : widget.onTab,
          onEditingComplete: _formatAmount, // formats input on blur
          style: const TextStyle(fontSize: 14),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '${widget.label} is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
