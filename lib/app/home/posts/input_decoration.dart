import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF9B442B),
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9B442B), width: 2)),
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        labelStyle:
            const TextStyle(fontFamily: 'Poppins', color: Color(0xFF9B442B)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color(0xFF9B442B))
            : null);
  }
}
