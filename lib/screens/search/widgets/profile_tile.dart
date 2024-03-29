import 'package:bigbelly/screens/follower_request/follower_request.dart';
import 'package:bigbelly/screens/profilePage/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import '../../imports.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.username,
      this.followerCount,
      this.requestId = -1,
      this.updateFollowerRequests,
      this.imageURL});

  final String username;
  final int? followerCount;
  final int requestId;
  final Function? updateFollowerRequests;
  final String? imageURL;

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
                child: imageURL == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(defaultProfileImage),
                        radius: 20.0.h,
                      )
                    : CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: Image.network(imageURL.toString()),
                        ),
                      ),
              ),
              title: Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: 100.w,
                height: 75.h,
                child: requestId != -1 ? requestAction() : null,
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
            Response response = await dio.post("/profile/followers/accept",
                data: {"request_id": requestId});
            updateFollowerRequests!();
          },
        ),
        IconButton(
            onPressed: () async {
              Response response = await dio.post("/profile/followers/decline",
                  data: {"request_id": requestId});
              updateFollowerRequests!();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ))
      ],
    );
  }
}
