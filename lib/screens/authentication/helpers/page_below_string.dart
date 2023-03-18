import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../login/login_screen.dart';

class PageBelowString extends StatelessWidget {
  PageBelowString(
      {super.key,
      this.fontSize = 16,
      required this.actionString,
      required this.longString});
  String actionString;
  int fontSize;
  String longString;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 25.h, 0, 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(style: TextStyle(fontSize: fontSize.sp), longString),
          TextButton(
            style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(color: Color.fromARGB(255, 143, 160, 78))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginScreen())));
            },
            child: Text(actionString),
          ),
        ],
      ),
    );
  }
}
