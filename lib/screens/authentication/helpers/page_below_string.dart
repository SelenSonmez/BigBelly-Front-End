import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../login/login_screen.dart';

class PageBelowString extends StatelessWidget {
  PageBelowString(
      {super.key,
      this.fontSize = 16,
      required this.actionString,
      required this.longString,
      required this.type});
  String actionString;
  int fontSize;
  String longString;
  String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(style: TextStyle(fontSize: fontSize.sp), longString),
          TextButton(
            style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(color: Color.fromARGB(255, 143, 160, 78))),
            onPressed: () {
              if (type == "login") {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => RegisterScreen())));
              }
            },
            child: Text(actionString),
          ),
        ],
      ),
    );
  }
}
