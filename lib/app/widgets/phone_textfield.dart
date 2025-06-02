import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextfield {
  static Widget mainPhoneField({
    double width = double.infinity,
    double? height,
    String initialCountryCode = 'BF',
    String hintText = '',
    Color borderColor = Colors.blue,
    Color fillColor = Colors.transparent,
    bool filled = true,
    double radius = 10,
    TextStyle? hintStyle,
    TextStyle? textStyle,
    void Function(PhoneNumber)? onChanged,
    void Function(PhoneNumber?)? onSaved,
    void Function(String)? onCountryChanged,
    PhoneNumber? initialValue,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<PhoneNumber>? validator,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: IntlPhoneField(
        autovalidateMode: AutovalidateMode.disabled,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: inputFormatters,
        initialCountryCode: initialCountryCode,
        
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          counterText: '',
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                color: Colors.grey.withOpacity(0.7),
                fontSize: 13,
              ),
          filled: filled,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:const BorderSide(color: Colors.red, width: 1),
          ),
          
        ),
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        onCountryChanged: (country) {
          if (onCountryChanged != null) {
            onCountryChanged(country.code);
          }
        },
        initialValue: '',
        style: textStyle,
      ),
    );
  }
}
