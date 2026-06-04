import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';

InputDecoration customInputDecoration(
  String label,
  IconData icon, {
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,

    prefixIcon: Icon(
      icon,
      color: secondaryColor,
    ),

    suffixIcon: suffixIcon,

    filled: true,
    fillColor: primaryColor,

    labelStyle: inputLabelStyle,

    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: secondaryColor.withValues(alpha: 0.2),
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: secondaryColor.withValues(alpha: 0.2),
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: secondaryColor,
        width: 1.2,
      ),
    ),
  );
}