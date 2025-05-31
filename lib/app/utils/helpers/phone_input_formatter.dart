import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  // Autorise : chiffres, tirets, parenthèses, espace, plus
  final RegExp _allowedChars = RegExp(r'^[0-9\s\-\+\(\)]*$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_allowedChars.hasMatch(newValue.text)) {
      return newValue;
    }
    // Si texte invalide, on garde l'ancien
    return oldValue;
  }
}
