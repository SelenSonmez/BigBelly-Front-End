import 'package:bigbelly/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class postReactions extends StatelessWidget {
  const postReactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
          size: 23.h,
          likeCount: 121,
          likeBuilder: (isLiked) {
            final color = isLiked ? Colors.red : Colors.green;
            return Icon(Icons.favorite, color: color);
          },
        ),
        reactionIconAndCount(const Icon(Icons.comment_rounded), true),
        reactionIconAndCount(const Icon(Icons.bookmark), false),
        reactionIconAndCount(const Icon(Icons.replay_sharp), false),
        reactionIconAndCount(const Icon(Icons.star), false),
      ],
    );
  }

  Widget reactionIconAndCount(Icon icon, bool isCountable) {
    return Row(
      children: [
        IconButton(
          color: mainThemeColor,
          iconSize: 23.h,
          icon: icon,
          onPressed: () {},
        ),
        Text(
          isCountable ? "2234" : " ",
        )
      ],
    );
  }
}
