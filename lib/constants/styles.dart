import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

String defaultProfileImage = "assets/images/defaultProfilePic.jpg";
String logoImage = "assets/images/logo.png";

OutlineInputBorder textFieldDecoration = OutlineInputBorder(
  borderSide: BorderSide(
    color: textFieldGray,
    width: 2.0.w,
  ),
  borderRadius: textFieldCircleRadius,
);

ButtonStyle registerLoginButtonStyle = ElevatedButton.styleFrom(
    elevation: 5.h,
    minimumSize: Size.fromHeight(50.h),
    backgroundColor: mainThemeColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.w),
    ));

TextStyle registerLoginButtonTextStyle = TextStyle(
  fontSize: 20.sp,
  color: Colors.white,
);
