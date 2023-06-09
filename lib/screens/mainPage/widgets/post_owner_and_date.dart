import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/styles.dart';
import '../../model/post.dart';
import '../texts.dart';

class PostOwnerAndDate extends ConsumerWidget {
  PostOwnerAndDate({super.key, required this.post});
  Post post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: Text(post.account!.username!),
              ),
            ],
          ),
          Text(calculateDays(post))
        ],
      ),
    );
  }

  String calculateDays(Post post) {
    String date = post.dateCreated!.split("T")[0];
    var dateParsed = date.split("-");
    DateTime dateTime = DateTime(int.parse(dateParsed[0]),
        int.parse(dateParsed[1]), int.parse(dateParsed[2]));
    DateTime now = DateTime.now();
    Duration diff = now.difference(dateTime);
    if (diff.inDays != 0) {
      return "${diff.inDays} $DaysAgo";
    }
    return Today;
  }
}
