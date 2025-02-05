import 'package:flutter/material.dart';

class AuthInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final bool hasSuffix;
  final String title;
  final String? Function(String?) validator;
  const AuthInputField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.hasSuffix = false,
    required this.title,
    required this.validator,
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  final FocusNode _focusNode = FocusNode();

  bool _isValid = false;
  late bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    // Add a listener to unfocus automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _validateInput(String? value) {
    final isValid = widget.validator.call(value) == null;
    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(79, 18, 113, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Text Form Field
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          onChanged: _validateInput,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(232, 255, 223, 253),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: _isValid ? Colors.green : Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: _isValid
                      ? Colors.green
                      : const Color.fromRGBO(79, 18, 113, 1)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 110, 110, 110),
            ),
            suffixIcon: widget.hasSuffix
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText
                          ? Color.fromARGB(255, 68, 70, 50)
                          : Color.fromRGBO(79, 18, 113, 1),
                    ),
                  )
                : null,
          ),
          obscureText: _obscureText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          keyboardType:
              widget.title == 'Email' ? TextInputType.emailAddress : null,
        ),
      ],
    );
  }
}
