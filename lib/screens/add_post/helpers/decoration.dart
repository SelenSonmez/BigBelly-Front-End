import 'package:flutter/material.dart';

InputDecoration postTextFieldDecoration(String labelText, String hintText) {
  return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: const TextStyle(color: Colors.green),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)));
}
