import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../login/LoginScreen.dart';

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
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
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
