// lib/utils/validators.dart
String? validateNo(String? value) {
  if (value == null || value.isEmpty) {
    return 'No is required';
  }

  if (int.tryParse(value) == null) {
    return 'No must be number';
  }
  return null;
}

String? validateJobNo(String? value) {
  if (value == null || value.isEmpty) {
    return 'Job No. is required';
  }
  if (!RegExp(r'^[a-zA-Z0-9\-]+$').hasMatch(value)) {
    return 'Job No. must contain letters, numbers, and hyphens only';
  }
  return null;
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Date is required';
  }
  final RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
  if (!dateRegex.hasMatch(value)) {
    return 'Enter a valid date (dd-MM-yyyy)';
  }
  return null;
}
