import 'package:bigbelly/constants/Colors.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration {
  static InputDecoration AuthenticationTextFieldDecoration(
      {Icon? icon, String? labelText, String? hintText}) {
    return InputDecoration(
      suffixIcon: icon,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: mainThemeColor,
          width: 1.5,
        ),
        borderRadius: textFieldCircleRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: textFieldGray,
          width: 2.0,
        ),
        borderRadius: textFieldCircleRadius,
      ),
      labelText: labelText,
      hintText: hintText,
    );
  }
}
