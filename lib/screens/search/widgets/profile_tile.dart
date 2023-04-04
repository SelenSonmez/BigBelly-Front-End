import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import '../../imports.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.username,
      required this.followerCount,
      this.isRequest = false});

  final String username;
  final int followerCount;
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.h),
      child: Card(
        shadowColor: Colors.green.shade500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.w),
        ),
        elevation: 7,
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
              trailing: SizedBox(
                width: 100.w,
                height: 75.h,
                child: isRequest
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          onPressed: () async {
            Response response =
                await dio.post("/profile/followers/accept", data: "");
          },
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ))
      ],
    );
  }
}
