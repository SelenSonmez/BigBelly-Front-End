import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/providers/post_provider.dart';
import '../../../constants/styles.dart';
import '../texts.dart';

class PostOwnerAndDate extends ConsumerWidget {
  const PostOwnerAndDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var post = ref.watch(postProvider).getPost;
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
          Text("2 " + DaysAgo)
        ],
      ),
    );
  }
}
