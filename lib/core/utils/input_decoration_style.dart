import 'package:flutter/material.dart';
import 'package:timepomodoro_app/core/theme/colors.dart';


InputDecoration inputStyle(
    String? errorText, String label, IconData? prefixIcon, Widget? suffixIcon) {
  return InputDecoration(
    suffixIconColor: blackColor,
    suffixIcon: suffixIcon,
    errorText: errorText,
    labelText: label,
    fillColor: whiteColor,
    hintText: label,
    errorMaxLines: 2,
    labelStyle: const TextStyle(color: whiteColor), // Estilo del texto del label
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorStyle: const TextStyle(
      color: redColor,
      fontWeight: FontWeight.bold,
    ),
    hintStyle: const TextStyle(color: whiteColor), // Estilo del texto del placeholder
  );
}
