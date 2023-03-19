import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key, required this.username, required this.followerCount});
  final String username;
  final int followerCount;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: mainThemeColor,
              radius: 22.h,
              child: CircleAvatar(
                backgroundImage: AssetImage(defaultProfileImage),
                radius: 20.0.h,
              ),
            ),
            title: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("$followerCount Followers"),
          ),
        ],
      ),
    );
  }
}
