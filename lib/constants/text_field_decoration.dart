import 'package:bigbelly/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldDecoration {
  static InputDecoration AuthenticationTextFieldDecoration(
      {Icon? icon, String? labelText, String? hintText}) {
    return InputDecoration(
      suffixIcon: icon,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: mainThemeColor,
          width: 1.5.w,
        ),
        borderRadius: textFieldCircleRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: textFieldGray,
          width: 2.0.w,
        ),
        borderRadius: textFieldCircleRadius,
      ),
      labelText: labelText,
      hintText: hintText,
    );
  }
}
