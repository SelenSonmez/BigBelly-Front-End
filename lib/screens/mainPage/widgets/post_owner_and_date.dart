import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/styles.dart';
import '../texts.dart';

class PostOwnerAndDate extends StatelessWidget {
  const PostOwnerAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //owner avatar and name
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20.0.h,
                child: CircleAvatar(
                  backgroundImage: AssetImage(defaultProfileImage),
                  radius: 18.0.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: const Text("Somer Şef"),
              ),
            ],
          ),
          Text("2 " + DaysAgo)
        ],
      ),
    );
  }
}
